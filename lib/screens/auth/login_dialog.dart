import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'sign_up_dialog.dart';

class LoginDialog extends StatefulWidget {
  @override
  _LoginDialogState createState() => _LoginDialogState();
}

class _LoginDialogState extends State<LoginDialog> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _errorMessage = '';

  Future<void> _signInWithEmailPassword() async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      Navigator.of(context).pop(); // 로그인 성공 시 팝업 닫기
    } on FirebaseAuthException catch (e) {
      setState(() {
        _errorMessage = e.message ?? '로그인에 실패했습니다.';
      });
    }
  }

  Future<void> _signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return; // 사용자가 로그인 취소 시

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _auth.signInWithCredential(credential);
      Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      setState(() {
        _errorMessage = '구글 로그인에 실패했습니다.';
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
                      SizedBox(height: 10),
                      Text(
                        '환영합니다!',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
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
                    Text(
                      '로그인',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(labelText: '이메일을 입력하세요.'),
                    ),
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(labelText: '비밀번호'),
                      onSubmitted: (_) => _signInWithEmailPassword(), // 엔터로 로그인
                    ),
                    SizedBox(height: 8),
                    Text(
                      _errorMessage,
                      style: TextStyle(color: Colors.red),
                    ),
                    SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: _signInWithEmailPassword,
                      child: Text('로그인'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF003366),
                        foregroundColor: Colors.white,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text('소셜 계정으로 로그인', style: TextStyle(fontSize: 14)),
                    IconButton(
                      icon: Text(
                        'G',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF003366),
                        ),
                      ),
                      onPressed: _signInWithGoogle,
                      tooltip: '구글로 로그인',
                    ),
                    SizedBox(height: 8),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        showDialog(context: context, builder: (context) => SignUpDialog());
                      },
                      child: Text('아직 회원이 아니신가요? 회원가입', style: TextStyle(color: Color(0xFF003366))),
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
