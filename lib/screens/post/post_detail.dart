import 'package:flutter/material.dart';
import '../../services/post_service.dart';

class PostDetailScreen extends StatelessWidget {
  final String postId;
  final PostService _postService = PostService();

  PostDetailScreen({required this.postId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post Details'),
      ),
      body: FutureBuilder<Map<String, dynamic>?>(
        future: _postService.getPostById(postId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text('Post not found'));
          }
          final post = snapshot.data!;
          return Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(post['title'], style: Theme.of(context).textTheme.headlineSmall),
                SizedBox(height: 10),
                Text(post['content'], style: Theme.of(context).textTheme.bodyLarge),
              ],
            ),
          );
        },
      ),
    );
  }
}
