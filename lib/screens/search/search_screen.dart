import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<String> _searchResults = []; // 예시용 검색 결과 데이터

  void _performSearch(String query) {
    // 검색 로직을 추가하세요.
    setState(() {
      _searchResults = [
        '검색 결과 1',
        '검색 결과 2',
        '검색 결과 3',
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // 배경색을 흰색으로 설정
      appBar: AppBar(
        title: Text(
          '검색',
          style: TextStyle(color: Color(0xFF003366)),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Color(0xFF003366)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // 검색 입력창
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                controller: _searchController,
                onSubmitted: _performSearch,
                decoration: InputDecoration(
                  hintText: '검색어를 입력하세요',
                  prefixIcon: Icon(Icons.search, color: Color(0xFF003366)),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),
            ),
            SizedBox(height: 16),
            // 검색 결과 리스트
            Expanded(
              child: _searchResults.isEmpty
                  ? Center(
                child: Text(
                  '검색 결과가 없습니다.',
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
              )
                  : ListView.builder(
                itemCount: _searchResults.length,
                itemBuilder: (context, index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text(
                        _searchResults[index],
                        style: TextStyle(
                          color: Color(0xFF003366),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: Icon(Icons.arrow_forward, color: Color(0xFF003366)),
                      onTap: () {
                        // 검색 결과 클릭 시 동작 추가
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
