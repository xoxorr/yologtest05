import 'package:cloud_firestore/cloud_firestore.dart';

// lib/models/post_model.dart
class PostModel {
  final String id;
  final String title;
  final String content;
  final String author;
  final String imageUrl;
  final DateTime createdAt;
  final int likes;

  PostModel({
    required this.id,
    required this.title,
    required this.content,
    required this.author,
    required this.imageUrl,
    required this.createdAt,
    required this.likes,
  });

  // Firebase 데이터를 객체로 변환
  factory PostModel.fromMap(Map<String, dynamic> data, String documentId) {
    return PostModel(
      id: documentId,
      title: data['title'] ?? '',
      content: data['content'] ?? '',
      author: data['author'] ?? 'Anonymous',
      imageUrl: data['imageUrl'] ?? '',
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      likes: data['likes'] ?? 0,
    );
  }

  // 객체를 Firebase 데이터로 변환
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'content': content,
      'author': author,
      'imageUrl': imageUrl,
      'createdAt': createdAt,
      'likes': likes,
    };
  }
}
