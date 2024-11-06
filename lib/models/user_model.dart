// lib/models/user_model.dart
class UserModel {
  final String uid;
  final String email;
  final String displayName;
  final String photoUrl;

  UserModel({
    required this.uid,
    required this.email,
    required this.displayName,
    required this.photoUrl,
  });

  // Firebase 데이터를 객체로 변환
  factory UserModel.fromMap(Map<String, dynamic> data) {
    return UserModel(
      uid: data['uid'] ?? '',
      email: data['email'] ?? '',
      displayName: data['displayName'] ?? 'User',
      photoUrl: data['photoUrl'] ?? '',
    );
  }

  // 객체를 Firebase 데이터로 변환
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'displayName': displayName,
      'photoUrl': photoUrl,
    };
  }
}
