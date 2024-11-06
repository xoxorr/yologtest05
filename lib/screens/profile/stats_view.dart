import 'package:flutter/material.dart';

class StatsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('통계 보기'),
      ),
      body: Center(
        child: Text('통계 데이터가 여기에 표시됩니다.'),
      ),
    );
  }
}
