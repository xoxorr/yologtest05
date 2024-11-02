import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DetailScreen extends StatelessWidget {
  final DocumentSnapshot post;

  DetailScreen({required this.post});

  @override
  Widget build(BuildContext context) {
    var postData = post.data() as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(
        title: Text(postData['title'] ?? '게시글 상세'),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Color(0xFF003366)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (postData.containsKey('imageUrl'))
              Image.network(
                postData['imageUrl'],
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
            SizedBox(height: 16),
            Text(
              postData['title'] ?? '제목 없음',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF003366),
              ),
            ),
            SizedBox(height: 8),
            Text(
              '작성자: ${postData['author'] ?? 'Unknown'}',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            SizedBox(height: 8),
            Text(
              postData['content'] ?? '내용 없음',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              '작성일: ${postData['createdAt'] != null ? postData['createdAt'].toDate().toLocal().toString().split(' ')[0] : '날짜 없음'}',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
