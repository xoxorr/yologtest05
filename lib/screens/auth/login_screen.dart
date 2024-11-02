import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../home/home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _errorMessage = '';

  Future<void> _signIn() async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        _errorMessage = e.message ?? '로그인에 실패했습니다.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('로그인', style: TextStyle(color: Color(0xFF003366))),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Color(0xFF003366)),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: '이메일',
                labelStyle: TextStyle(color: Color(0xFF003366)),
                prefixIcon: Icon(Icons.email, color: Color(0xFF003366)),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF003366)),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF003366)),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: '비밀번호',
                labelStyle: TextStyle(color: Color(0xFF003366)),
                prefixIcon: Icon(Icons.lock, color: Color(0xFF003366)),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF003366)),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF003366)),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            SizedBox(height: 16),
            Text(
              _errorMessage,
              style: TextStyle(color: Colors.red),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _signIn,
              child: Text('로그인'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF003366), // primary 대신 backgroundColor 사용
                foregroundColor: Colors.white, // onPrimary 대신 foregroundColor 사용
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
