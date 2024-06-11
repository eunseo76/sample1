import 'package:flutter/material.dart';
import 'travelpage.dart';
import 'mappage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: '메인 페이지'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({required this.title});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    HomeTab(),
    TravelPage(),
    MapPage(),
    Text('Community Page', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
    Text('Special Page', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
  ];

  void _onItemTapped(int index) {
    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => TravelPage()),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MapPage()),
      );
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: [
            IconButton(
              icon: Icon(Icons.person),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TravelPage()),
                );
              },
            ),
          ],
          bottom: TabBar(
            tabs: [
              Tab(text: '홈'),
              Tab(text: '추천'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            HomeTab(),
            RecommendTab(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
            BottomNavigationBarItem(icon: Icon(Icons.shopping_bag_outlined), label: '테마여행'),
            BottomNavigationBarItem(icon: Icon(Icons.map), label: '지도'),
            BottomNavigationBarItem(icon: Icon(Icons.list_alt_sharp), label: '후기 게시판'),
            BottomNavigationBarItem(icon: Icon(Icons.wifi_protected_setup), label: '특수 기능'),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.blue,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }
}

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: '어떤 애니메이션을 찾으시나요?',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: GridView.count(
              crossAxisCount: 4,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                _buildCategoryItem(Icons.animation, '너의 이름은'),
                _buildCategoryItem(Icons.animation, '토토로'),
                _buildCategoryItem(Icons.animation, '슬램덩크'),
                _buildCategoryItem(Icons.animation, '센과 치히로'),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Container(
              color: Colors.grey[300],
              height: 150,
              child: Center(child: Text('추천 테마')),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('일본 축제', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                Container(
                  height: 200,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _buildRecommendationItem('축제1'),
                      _buildRecommendationItem('축제2'),
                      _buildRecommendationItem('축제3'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(IconData icon, String label) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 40),
        SizedBox(height: 5),
        Text(label, textAlign: TextAlign.center, style: TextStyle(fontSize: 12)),
      ],
    );
  }

  Widget _buildRecommendationItem(String location) {
    return Padding(
      padding: EdgeInsets.only(right: 10.0),
      child: Container(
        width: 150,
        color: Colors.grey[300],
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 100,
                color: Colors.grey[400],
                child: Center(child: Text('여행지 정보')),
              ),
              SizedBox(height: 5),
              Text(location, style: TextStyle(fontSize: 14)),
            ],
          ),
        ),
      ),
    );
  }
}

class RecommendTab extends StatefulWidget {
  @override
  _RecommendTabState createState() => _RecommendTabState();
}

class _RecommendTabState extends State<RecommendTab> {
  List<Map<String, String>> destinations = [
    {'name': '여행지 1', 'description': '여행지 1에 대한 설명'},
    {'name': '여행지 2', 'description': '여행지 2에 대한 설명'},
    {'name': '여행지 3', 'description': '여행지 3에 대한 설명'},
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: destinations.map((destination) {
          return Dismissible(
            key: Key(destination['name']!),
            onDismissed: (direction) {
              setState(() {
                destinations.remove(destination);
              });

              String action = direction == DismissDirection.endToStart
                  ? '삭제됨'
                  : '찜됨';

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${destination['name']} $action'),
                ),
              );
            },
            background: Container(
              color: Colors.green,
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Icon(Icons.favorite, color: Colors.white),
            ),
            secondaryBackground: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Icon(Icons.delete, color: Colors.white),
            ),
            child: Card(
              margin: EdgeInsets.symmetric(vertical: 50, horizontal: 10),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.7,
                width: MediaQuery.of(context).size.width * 0.9, // 가로 크기 조정
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.image, size: 100),
                    SizedBox(height: 20),
                    Text(destination['name']!, style: TextStyle(fontSize: 24)),
                    SizedBox(height: 10),
                    Text(destination['description']!, style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}