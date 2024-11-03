import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PostCreateScreen extends StatefulWidget {
  @override
  _PostCreateScreenState createState() => _PostCreateScreenState();
}

class _PostCreateScreenState extends State<PostCreateScreen> {
  final _titleController = TextEditingController();
  final _tagController = TextEditingController();
  final _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // 전체 배경색 흰색
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 40), // 상단 여백 추가
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                hintText: '제목을 입력하세요',
                hintStyle: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[600],
                ),
                border: InputBorder.none,
              ),
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20), // 간격 조정
            TextField(
              controller: _tagController,
              decoration: InputDecoration(
                hintText: '태그를 입력하세요',
                hintStyle: TextStyle(fontSize: 18, color: Colors.grey[600]),
                border: InputBorder.none,
              ),
            ),
            SizedBox(height: 10), // 간격 조정

            Expanded(
              child: TextField(
                controller: _contentController,
                decoration: InputDecoration(
                  hintText: '당신의 이야기를 들려주세요!',
                  border: InputBorder.none,
                ),
                maxLines: null,
                expands: true,
                keyboardType: TextInputType.multiline,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.white, // 하단 바 색상을 흰색으로 설정
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('나가기', style: TextStyle(color: Colors.black)), // "나가기" 글씨 색상을 검정색으로 변경
            ),
            ElevatedButton(
              onPressed: () async {
                await _savePost();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF003366), // Yolog 색상
                foregroundColor: Colors.black, // "출간하기" 글씨 색상을 검정색으로 설정
              ),
              child: Text('출간하기'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _savePost() async {
    final userId = FirebaseAuth.instance.currentUser?.uid ?? 'unknown';
    final title = _titleController.text;
    final tag = _tagController.text;
    final content = _contentController.text;

    await FirebaseFirestore.instance.collection('posts').add({
      'userId': userId,
      'title': title,
      'tag': tag,
      'content': content,
      'createdAt': FieldValue.serverTimestamp(),
    });

    Navigator.of(context).pop();
  }
}
