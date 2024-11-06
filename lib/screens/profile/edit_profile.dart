import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _displayNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    if (user != null) {
      _displayNameController.text = user!.displayName ?? '';
      _emailController.text = user!.email ?? '';
    }
  }

  void _updateProfile() async {
    if (user != null) {
      try {
        await user!.updateDisplayName(_displayNameController.text);
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uid)
            .update({
          'displayName': _displayNameController.text,
          'email': _emailController.text,
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('프로필이 업데이트되었습니다.')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('오류가 발생했습니다. 다시 시도해주세요.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('프로필 수정'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _displayNameController,
              decoration: InputDecoration(labelText: '이름'),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: '이메일'),
              readOnly: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _updateProfile,
              child: Text('프로필 저장'),
            ),
          ],
        ),
      ),
    );
  }
}
