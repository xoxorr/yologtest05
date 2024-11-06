import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Firebase Auth 가져오기
import 'auth_service.dart'; // AuthService 경로 확인하고 수정

class LoginDialog extends StatefulWidget {
  @override
  _LoginDialogState createState() => _LoginDialogState();
}

class _LoginDialogState extends State<LoginDialog> {
  final AuthService _authService = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLoading = false;

  void _signIn() async {
    setState(() {
      isLoading = true;
    });

    try {
      User? user = await _authService.signInWithEmailAndPassword(
        _emailController.text,
        _passwordController.text,
      );

      if (user != null) {
        // 로그인 성공 처리
        Navigator.of(context).pop();
      } else {
        // 로그인 실패 처리
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('로그인에 실패했습니다.')),
        );
      }
    } catch (e) {
      // 에러 처리
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('에러가 발생했습니다: $e')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('로그인'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _emailController,
            decoration: InputDecoration(labelText: '이메일'),
          ),
          TextField(
            controller: _passwordController,
            decoration: InputDecoration(labelText: '비밀번호'),
            obscureText: true,
          ),
        ],
      ),
      actions: [
        isLoading
            ? CircularProgressIndicator()
            : TextButton(
          onPressed: _signIn,
          child: Text('로그인'),
        ),
      ],
    );
  }
}
