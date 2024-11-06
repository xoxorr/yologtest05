import 'package:flutter/material.dart';

class AdvancedSearchScreen extends StatefulWidget {
  @override
  _AdvancedSearchScreenState createState() => _AdvancedSearchScreenState();
}

class _AdvancedSearchScreenState extends State<AdvancedSearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('고급 검색'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: '검색어를 입력하세요',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    // 고급 검색 로직 추가
                  },
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    title: Text('검색 결과 1'),
                    onTap: () {
                      // 결과 클릭 시 동작 추가
                    },
                  ),
                  ListTile(
                    title: Text('검색 결과 2'),
                    onTap: () {
                      // 결과 클릭 시 동작 추가
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
