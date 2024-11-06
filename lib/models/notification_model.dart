import 'package:cloud_firestore/cloud_firestore.dart';

// lib/models/notification_model.dart
class NotificationModel {
  final String id;
  final String title;
  final String body;
  final DateTime createdAt;

  NotificationModel({
    required this.id,
    required this.title,
    required this.body,
    required this.createdAt,
  });

  // Firebase 데이터를 객체로 변환
  factory NotificationModel.fromMap(Map<String, dynamic> data, String documentId) {
    return NotificationModel(
      id: documentId,
      title: data['title'] ?? '',
      body: data['body'] ?? '',
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }

  // 객체를 Firebase 데이터로 변환
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'body': body,
      'createdAt': createdAt,
    };
  }
}
