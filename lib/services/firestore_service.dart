import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // 포스트 추가
  Future<void> addPost(Map<String, dynamic> postData) async {
    try {
      await _firestore.collection('posts').add(postData);
    } catch (e) {
      print("Error adding post: $e");
    }
  }

  // 포스트 가져오기
  Stream<QuerySnapshot> getPosts() {
    return _firestore.collection('posts').snapshots();
  }

  // 포스트 업데이트
  Future<void> updatePost(String postId, Map<String, dynamic> updatedData) async {
    try {
      await _firestore.collection('posts').doc(postId).update(updatedData);
    } catch (e) {
      print("Error updating post: $e");
    }
  }

  // 포스트 삭제
  Future<void> deletePost(String postId) async {
    try {
      await _firestore.collection('posts').doc(postId).delete();
    } catch (e) {
      print("Error deleting post: $e");
    }
  }
}
