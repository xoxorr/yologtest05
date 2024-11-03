import 'package:cloud_firestore/cloud_firestore.dart';

class PostService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // 게시물 생성 메서드
  Future<void> createPost(String userId, String title, String content) async {
    await _firestore.collection('posts').add({
      'userId': userId,
      'title': title,
      'content': content,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  // 특정 게시물을 postId로 불러오는 메서드
  Future<Map<String, dynamic>?> getPostById(String postId) async {
    try {
      DocumentSnapshot doc = await _firestore.collection('posts').doc(postId).get();
      return doc.exists ? doc.data() as Map<String, dynamic>? : null;
    } catch (e) {
      print("Error getting post by ID: $e");
      return null;
    }
  }

  // 모든 게시물을 스트림으로 불러오는 메서드
  Stream<List<Map<String, dynamic>>> getPosts() {
    return _firestore.collection('posts').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id; // Document ID 추가
        return data;
      }).toList();
    });
  }
}
