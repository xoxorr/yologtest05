import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'services/notification_service.dart';

import 'screens/home/home_screen.dart'; // HomeScreen 파일을 import


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  NotificationService notificationService = NotificationService();
  await notificationService.initialize();

  runApp(YologApp());
}

class YologApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Yolog',
      theme: ThemeData(
        primaryColor: Color(0xFF003366),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Poppins', // 전역 폰트 설정
      ),
      home: HomeScreen(), // HomeScreen을 초기 화면으로 설정
      debugShowCheckedModeBanner: false,
    );
  }
}