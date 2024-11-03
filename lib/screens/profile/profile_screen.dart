import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? _user;
  Map<String, dynamic>? _userData;

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  void _getUserData() async {
    _user = _auth.currentUser;
    if (_user != null) {
      DocumentSnapshot userDoc =
      await _firestore.collection('users').doc(_user!.uid).get();
      setState(() {
        _userData = userDoc.data() as Map<String, dynamic>?;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.notifications_none, color: Colors.grey),
                IconButton(
                  icon: Icon(Icons.close, color: Colors.grey),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            CircleAvatar(
              radius: 40,
              backgroundImage: _userData != null
                  ? NetworkImage(_userData!['profileImageUrl'] ?? 'https://via.placeholder.com/150')
                  : AssetImage('assets/default_profile.png') as ImageProvider,
            ),
            SizedBox(height: 10),
            Text(
              _userData != null ? _userData!['name'] ?? 'User' : 'User',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              _userData != null ? 'Lv. ${_userData!['level'] ?? 1}' : 'Lv. 1',
              style: TextStyle(color: Colors.orange, fontSize: 14),
            ),
            SizedBox(height: 30),
            _buildMenuItem(Icons.article_outlined, '내 글 보기', () {
              // 내 글 보기 기능 구현
            }),
            _buildMenuItem(Icons.edit_outlined, '새 글 작성', () {
              // 새 글 작성 기능 구현
            }),
            _buildMenuItem(Icons.message_outlined, '메시지', () {
              // 메시지 기능 구현
            }, badgeCount: 12), // 예시: 새 메시지가 12개 있다고 표시
            _buildMenuItem(Icons.person_outline, '프로필 관리', () {
              // 프로필 관리 기능 구현
            }),
            Spacer(),
            Divider(),
            _buildMenuItem(Icons.logout, '로그아웃', () async {
              await _auth.signOut();
              Navigator.of(context).pushReplacementNamed('/login'); // 로그인 화면으로 이동
            }),
            _buildMenuItem(Icons.settings, '설정', () {
              // 설정 기능 구현
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, VoidCallback onTap, {int? badgeCount}) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey),
      title: Text(title),
      trailing: badgeCount != null
          ? Container(
        padding: EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Colors.orange,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          badgeCount.toString(),
          style: TextStyle(color: Colors.white, fontSize: 12),
        ),
      )
          : null,
      onTap: onTap,
    );
  }
}
