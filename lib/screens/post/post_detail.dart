import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PostDetailScreen extends StatelessWidget {
  final String postId;

  PostDetailScreen({required this.postId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('게시글 상세'),
        backgroundColor: Color(0xFF003366),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection('posts').doc(postId).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(child: Text("게시글을 찾을 수 없습니다."));
          }

          var post = snapshot.data!.data() as Map<String, dynamic>;
          String title = post['title'] ?? '제목 없음';
          String content = post['content'] ?? '내용 없음';
          String author = post['author'] ?? 'Anonymous';
          DateTime createdAt = post['createdAt']?.toDate() ?? DateTime.now();

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF003366),
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'by $author · ${createdAt.toLocal().toString().split(' ')[0]}',
                  style: TextStyle(color: Colors.grey),
                ),
                Divider(height: 30),
                Expanded(
                  child: SingleChildScrollView(
                    child: Text(
                      content,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
