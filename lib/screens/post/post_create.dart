import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../services/post_service.dart';

class PostCreateScreen extends StatefulWidget {
  @override
  _PostCreateScreenState createState() => _PostCreateScreenState();
}

class _PostCreateScreenState extends State<PostCreateScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final PostService _postService = PostService();

  Future<void> _createPost() async {
    if (_formKey.currentState!.validate()) {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId != null) {
        await _postService.createPost(
          userId,
          _titleController.text,
          _contentController.text,
        );
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Post'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Title'),
                validator: (value) {
                  return value!.isEmpty ? 'Please enter a title' : null;
                },
              ),
              TextFormField(
                controller: _contentController,
                decoration: InputDecoration(labelText: 'Content'),
                validator: (value) {
                  return value!.isEmpty ? 'Please enter content' : null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _createPost,
                child: Text('Post'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
