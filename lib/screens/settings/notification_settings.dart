import 'package:flutter/material.dart';

class NotificationSettingsScreen extends StatefulWidget {
  @override
  _NotificationSettingsScreenState createState() =>
      _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState
    extends State<NotificationSettingsScreen> {
  bool _emailNotifications = true;
  bool _pushNotifications = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('알림 설정'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SwitchListTile(
              title: Text('이메일 알림'),
              value: _emailNotifications,
              onChanged: (bool value) {
                setState(() {
                  _emailNotifications = value;
                });
              },
            ),
            SwitchListTile(
              title: Text('푸시 알림'),
              value: _pushNotifications,
              onChanged: (bool value) {
                setState(() {
                  _pushNotifications = value;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // 알림 설정 저장 로직 추가
              },
              child: Text('저장'),
            ),
          ],
        ),
      ),
    );
  }
}
