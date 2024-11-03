import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'login_dialog.dart';

class SignUpDialog extends StatefulWidget {
  @override
  _SignUpDialogState createState() => _SignUpDialogState();
}

class _SignUpDialogState extends State<SignUpDialog> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final TextEditingController _emailController = TextEditingController();
  String _errorMessage = '';

  Future<void> _signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return;

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _auth.signInWithCredential(credential);
      Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      setState(() {
        _errorMessage = '구글 회원가입에 실패했습니다.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.7,
        height: MediaQuery.of(context).size.height * 0.5,
        child: Row(
          children: [
            Expanded(
              child: Container(
                color: Color(0xFF003366),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.emoji_people, size: 80, color: Colors.white),
                      Text('환영합니다!', style: TextStyle(color: Colors.white, fontSize: 24)),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('회원가입', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                    TextField(controller: _emailController, decoration: InputDecoration(labelText: '이메일을 입력하세요.')),
                    Text(_errorMessage, style: TextStyle(color: Colors.red)),
                    ElevatedButton(onPressed: () {}, child: Text('회원가입')),
                    Text('소셜 계정으로 회원가입'),
                    IconButton(icon: Text('G', style: TextStyle(fontSize: 24, color: Color(0xFF003366))), onPressed: _signInWithGoogle),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        showDialog(context: context, builder: (context) => LoginDialog());
                      },
                      child: Text('계정이 이미 있으신가요? 로그인', style: TextStyle(color: Color(0xFF003366))),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
