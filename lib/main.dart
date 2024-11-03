import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'config/routes.dart';
import 'config/theme.dart';
import 'screens/home/home_screen.dart'; // HomeScreen 파일을 import
import 'screens/post/post_create.dart';
import 'services/post_service.dart';
import 'screens/post/post_detail.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(YologApp());
}

class YologApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Yolog',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Poppins', // 전역 폰트 설정
      ),
      home: HomeScreen(), // HomeScreen을 초기 화면으로 설정
    );
  }
}