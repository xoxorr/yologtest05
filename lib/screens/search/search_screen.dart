import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../details/detail_screen.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Color(0xFF003366)),
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: '검색어 입력',
            border: InputBorder.none,
          ),
          autofocus: true,
          onChanged: (value) {
            setState(() {
              _searchQuery = value;
            });
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.close, color: Color(0xFF003366)),
            onPressed: () {
              _searchController.clear();
              setState(() {
                _searchQuery = '';
              });
            },
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: (_searchQuery.isEmpty)
            ? FirebaseFirestore.instance.collection('posts').snapshots()
            : FirebaseFirestore.instance
            .collection('posts')
            .where('title', isGreaterThanOrEqualTo: _searchQuery)
            .where('title', isLessThanOrEqualTo: _searchQuery + '\uf8ff')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text("검색 결과가 없습니다."));
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var post = snapshot.data!.docs[index];
              var postData = post.data() as Map<String, dynamic>;

              return ListTile(
                title: Text(postData['title'] ?? '제목 없음'),
                subtitle: Text(postData['content'] ?? '내용 없음'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailScreen(post: post),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
