import 'package:flutter/material.dart';
import 'notification_settings.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('설정'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('알림 설정'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NotificationSettingsScreen()),
              );
            },
          ),
          ListTile(
            title: Text('개인 정보 보호'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              // 개인정보 설정 화면 연결
            },
          ),
          ListTile(
            title: Text('계정 설정'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              // 계정 설정 화면 연결
            },
          ),
        ],
      ),
    );
  }
}
