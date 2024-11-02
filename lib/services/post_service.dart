import 'package:cloud_firestore/cloud_firestore.dart';

class PostService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // 기존 코드 예시
  Future<void> createPost(String userId, String title, String content) async {
    await _firestore.collection('Posts').add({
      'userId': userId,
      'title': title,
      'content': content,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  // 새로운 getPostById 메서드 추가
  Future<Map<String, dynamic>?> getPostById(String postId) async {
    try {
      DocumentSnapshot doc = await _firestore.collection('Posts').doc(postId).get();
      return doc.exists ? doc.data() as Map<String, dynamic>? : null;
    } catch (e) {
      print("Error getting post by ID: $e");
      return null;
    }
  }

  // Stream 방식으로 모든 게시물 불러오기
  Stream<List<Map<String, dynamic>>> getPosts() {
    return _firestore.collection('Posts').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id; // Document ID 추가
        return data;
      }).toList();
    });
  }
}
