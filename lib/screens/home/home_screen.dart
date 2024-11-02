import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../auth/login_screen.dart';

class HomeScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _signOut(BuildContext context) async {
    await _auth.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: null, // 뒤로 가기 화살표 제거
        automaticallyImplyLeading: false, // 자동으로 leading 아이콘 추가 방지
        title: GestureDetector(
          onTap: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
                  (route) => false,
            ); // 'Yolog' 클릭 시 홈 화면으로 이동
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
          _auth.currentUser == null
              ? TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              ); // 로그인 버튼 클릭 시 LoginScreen으로 이동
            },
            child: Text(
              '로그인',
              style: TextStyle(color: Color(0xFF003366)),
            ),
          )
              : PopupMenuButton<String>(
            icon: Icon(Icons.menu, color: Color(0xFF003366)),
            onSelected: (String result) {
              if (result == 'logout') {
                _signOut(context);
              } else if (result == 'profile') {
                // 프로필 화면 이동 기능 추가
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 검색창 섹션
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9, // 화면 폭에 맞추기
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: '검색어 입력',
                      prefixIcon: Icon(Icons.search, color: Color(0xFF003366)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Color(0xFF003366)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Color(0xFF003366)),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // 중앙 배너 섹션
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(
                    image: NetworkImage('https://via.placeholder.com/400'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      '중앙 배너 제목',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // 추천 목록 섹션
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                '추천 목록',
                style: TextStyle(
                  color: Color(0xFF003366),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 8),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 5, // 예시 데이터 개수
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Text(
                    '${index + 1}',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF003366),
                    ),
                  ),
                  title: Text('추천 포스트 제목 ${index + 1}'),
                  subtitle: Text('간단한 설명이나 부제목'),
                  onTap: () {
                    // 포스트 상세 화면으로 이동
                  },
                );
              },
            ),

            // 스토리 크리에이터 섹션
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: Text(
                '스토리 크리에이터',
                style: TextStyle(
                  color: Color(0xFF003366),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 3, // 예시 데이터 개수
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage('https://via.placeholder.com/100'),
                    ),
                    title: Text('크리에이터 ${index + 1}'),
                    subtitle: Text('구독자 100명 | 최근 게시물 제목'),
                    trailing: ElevatedButton(
                      onPressed: () {
                        // 구독 기능 추가
                      },
                      child: Text('구독'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF003366),
                        foregroundColor: Colors.white,
                      ),
                    ),
                    onTap: () {
                      // 크리에이터 페이지로 이동
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
