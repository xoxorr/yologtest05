import 'package:flutter/material.dart';

class WriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('글쓰기', style: TextStyle(color: Color(0xFF003366))),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Color(0xFF003366)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: '제목',
                labelStyle: TextStyle(color: Color(0xFF003366)),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF003366)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF003366)),
                ),
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: TextField(
                maxLines: null,
                expands: true,
                decoration: InputDecoration(
                  labelText: '내용',
                  labelStyle: TextStyle(color: Color(0xFF003366)),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF003366)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF003366)),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // 글 저장 로직 추가 가능
              },
              child: Text('저장'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF003366),
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
