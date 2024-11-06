import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PostCreateScreen extends StatefulWidget {
  @override
  _PostCreateScreenState createState() => _PostCreateScreenState();
}

class _PostCreateScreenState extends State<PostCreateScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _submitPost() async {
    if (_titleController.text.isEmpty || _contentController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('제목과 내용을 모두 입력해주세요.')),
      );
      return;
    }

    final user = _auth.currentUser;
    if (user == null) return;

    await FirebaseFirestore.instance.collection('posts').add({
      'title': _titleController.text,
      'content': _contentController.text,
      'author': user.displayName ?? 'Anonymous',
      'createdAt': Timestamp.now(),
    });

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('게시글 작성'),
        backgroundColor: Color(0xFF003366),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: '제목'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _contentController,
              decoration: InputDecoration(labelText: '내용'),
              maxLines: 5,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _submitPost,
              child: Text('출간하기'),
              style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF003366)),
            ),
          ],
        ),
      ),
    );
  }
}
