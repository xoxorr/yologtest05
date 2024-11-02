import 'package:flutter/material.dart';
import '../screens/home/home_screen.dart';
import '../screens/post/post_create.dart';
import '../screens/post/post_detail.dart';
import '../screens/profile/profile_screen.dart';
import '../screens/auth/login_screen.dart';

class AppRoutes {
  static const String home = '/home';
  static const String login = '/login';
  static const String postDetail = '/postDetail';
  static const String postCreate = '/postCreate';
  static const String profile = '/profile';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case login:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case postDetail:
        return MaterialPageRoute(
          builder: (_) => PostDetailScreen(postId: settings.arguments as String),
        );
      case postCreate:
        return MaterialPageRoute(builder: (_) => PostCreateScreen());
      case profile:
        return MaterialPageRoute(
          builder: (_) => ProfileScreen(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
