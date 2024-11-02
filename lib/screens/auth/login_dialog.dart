import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
      // 구글 계정으로 로그인
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return; // 사용자가 로그인 취소 시 반환

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Firebase에 인증 정보로 로그인 시도
      await _auth.signInWithCredential(credential);

      // 로그인 후 팝업 닫기
      Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      setState(() {
        _errorMessage = '구글 로그인에 실패했습니다.';
      });
    } catch (e) {
      setState(() {
        _errorMessage = '로그인 도중 오류가 발생했습니다.';
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
            // 왼쪽 환영 이미지 및 메시지
            Expanded(
              child: Container(
                color: Color(0xFF003366), // Yolog 로고 색상으로 설정
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
            // 오른쪽 로그인 폼
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
                    ),
                    SizedBox(height: 8),
                    Text(_errorMessage, style: TextStyle(color: Colors.red)),
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
                    SizedBox(height: 8),
                    // 구글 로그인 버튼 (아이콘 스타일)
                    IconButton(
                      icon: Text(
                        'G', // 'G' 텍스트를 아이콘처럼 사용
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF003366), // Yolog 로고 색상과 동일하게 설정
                        ),
                      ),
                      onPressed: _signInWithGoogle,
                      tooltip: '구글로 로그인',
                    ),
                    SizedBox(height: 8),
                    TextButton(
                      onPressed: () {
                        // 회원가입 페이지로 이동 기능 추가 가능
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
