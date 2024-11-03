import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../auth/login_dialog.dart'; // 로그인 팝업 임포트
import '../post/post_create.dart'; // 글쓰기 화면 연결
import '../profile/profile_screen.dart';
import '../search/search_screen.dart';
import '../details/detail_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _signOut(BuildContext context) async {
    await _auth.signOut();
    setState(() {}); // UI 업데이트
  }

  void _showLoginDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => LoginDialog(),
    ).then((_) {
      setState(() {}); // 로그인 후 UI 업데이트
    });
  }

  void _navigateToWriteScreen(BuildContext context) {
    if (_auth.currentUser == null) {
      _showLoginDialog(context);
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PostCreateScreen()), // PostCreateScreen으로 연결
      );
    }
  }

  void _navigateToProfileScreen(BuildContext context) {
    if (_auth.currentUser == null) {
      _showLoginDialog(context);
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProfileScreen()),
      );
    }
  }

  void _navigateToSearchScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SearchScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: GestureDetector(
          onTap: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
                  (route) => false,
            );
          },
          child: Text(
            'Yolog',
            style: TextStyle(
              color: Color(0xFF003366),
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Color(0xFF003366)),
            onPressed: () => _navigateToSearchScreen(context),
          ),
          _auth.currentUser == null
              ? TextButton(
            onPressed: () => _showLoginDialog(context),
            child: Text('로그인', style: TextStyle(color: Color(0xFF003366))),
          )
              : PopupMenuButton<String>(
            icon: Icon(Icons.menu, color: Color(0xFF003366)),
            onSelected: (String result) {
              if (result == 'logout') {
                _signOut(context);
              } else if (result == 'profile') {
                _navigateToProfileScreen(context);
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              PopupMenuItem<String>(
                value: 'profile',
                child: Text('프로필'),
              ),
              PopupMenuItem<String>(
                value: 'logout',
                child: Text('로그아웃'),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          TabBar(
            controller: _tabController,
            labelColor: Color(0xFF003366),
            unselectedLabelColor: Colors.grey,
            indicatorColor: Color(0xFF003366),
            labelStyle: TextStyle(fontWeight: FontWeight.bold),
            tabs: [
              Tab(icon: Icon(Icons.trending_up), text: "인기"),
              Tab(icon: Icon(Icons.access_time), text: "최신"),
              Tab(icon: Icon(Icons.rss_feed), text: "피드"),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                PostsList(filter: 'popular'),
                PostsList(filter: 'latest'),
                PostsList(filter: 'feed'),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToWriteScreen(context),
        backgroundColor: Color(0xFF003366),
        child: Icon(Icons.edit, color: Colors.white),
      ),
    );
  }
}

class PostsList extends StatelessWidget {
  final String filter;
  PostsList({required this.filter});

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> postStream;

    if (filter == 'popular') {
      postStream = FirebaseFirestore.instance.collection('posts').orderBy('likes', descending: true).snapshots();
    } else if (filter == 'latest') {
      postStream = FirebaseFirestore.instance.collection('posts').orderBy('createdAt', descending: true).snapshots();
    } else {
      postStream = FirebaseFirestore.instance.collection('posts').snapshots();
    }

    return StreamBuilder<QuerySnapshot>(
      stream: postStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text("게시글이 없습니다."));
        }
        return GridView.builder(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 300,
            childAspectRatio: 0.7,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
          ),
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            var post = snapshot.data!.docs[index];
            var postData = post.data() as Map<String, dynamic>;
            var imageUrl = postData.containsKey('imageUrl') ? postData['imageUrl'] : 'https://via.placeholder.com/150';

            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailScreen(post: post),
                  ),
                );
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: DecorationImage(
                              image: NetworkImage(imageUrl),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        postData['title'] ?? '제목 없음',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF003366),
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4),
                      Text(
                        'by ${postData['author'] ?? 'Unknown'}',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      Text(
                        postData['createdAt'] != null
                            ? postData['createdAt'].toDate().toLocal().toString().split(' ')[0]
                            : '날짜 없음',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
