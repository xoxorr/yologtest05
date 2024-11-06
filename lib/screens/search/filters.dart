import 'package:flutter/material.dart';

class FiltersScreen extends StatefulWidget {
  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _isChecked1 = false;
  bool _isChecked2 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('필터 설정'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CheckboxListTile(
              title: Text('필터 1'),
              value: _isChecked1,
              onChanged: (bool? value) {
                setState(() {
                  _isChecked1 = value ?? false;
                });
              },
            ),
            CheckboxListTile(
              title: Text('필터 2'),
              value: _isChecked2,
              onChanged: (bool? value) {
                setState(() {
                  _isChecked2 = value ?? false;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // 필터 적용 로직 추가
              },
              child: Text('필터 적용'),
            ),
          ],
        ),
      ),
    );
  }
}
