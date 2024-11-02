import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Color(0xFF003366), // 글씨 색상
  scaffoldBackgroundColor: Colors.white, // 배경 색상
  appBarTheme: AppBarTheme(
    color: Colors.white,
    iconTheme: IconThemeData(color: Color(0xFF003366)),
    titleTextStyle: TextStyle(color: Color(0xFF003366), fontSize: 20),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Colors.amber,
    foregroundColor: Colors.white,
  ),
  textTheme: TextTheme(
    bodyLarge: TextStyle(color: Color(0xFF003366)), // 변경된 부분
    bodyMedium: TextStyle(color: Color(0xFF003366)), // 변경된 부분
    titleLarge: TextStyle(color: Color(0xFF003366)), // 변경된 부분
  ),
  iconTheme: IconThemeData(color: Color(0xFF003366)),
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.white,
  scaffoldBackgroundColor: Color(0xFF121212), // 어두운 배경색
  appBarTheme: AppBarTheme(
    color: Color(0xFF333333),
    iconTheme: IconThemeData(color: Colors.white),
    titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Colors.amber,
    foregroundColor: Colors.black,
  ),
  textTheme: TextTheme(
    bodyLarge: TextStyle(color: Colors.white), // 변경된 부분
    bodyMedium: TextStyle(color: Colors.white), // 변경된 부분
    titleLarge: TextStyle(color: Colors.white), // 변경된 부분
  ),
  iconTheme: IconThemeData(color: Colors.white),
);
