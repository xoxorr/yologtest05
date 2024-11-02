import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileScreen extends StatelessWidget {
  final String userId;

  ProfileScreen({required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: FutureBuilder<User?>(
        future: _getUserData(userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData) {
            return Center(child: Text('User not found'));
          }
          final user = snapshot.data!;
          return Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Name: ${user.displayName ?? "Anonymous"}', style: Theme.of(context).textTheme.headlineMedium),
                SizedBox(height: 8),
                Text('Email: ${user.email}', style: Theme.of(context).textTheme.bodyLarge),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<User?> _getUserData(String userId) async {
    return FirebaseAuth.instance.currentUser;
  }
}
