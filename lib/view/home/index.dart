import 'package:flutter/material.dart';
import 'package:for_howl/view/playlist/index.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();
  // late MyAudioHandler myAudioHandler;

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  /// BottomNavigationBarItem 클릭 시 페이지 이동
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }


  @override
  void initState() {
    super.initState();
    // myAudioHandler = MyAudioHandler();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // TODO: 추후에 메뉴 적용되면 PageView 적용 예정, 현재는 사용되고 있지 않습니다.
        body: SafeArea(
          child: PageView(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            children: <Widget>[
              PlaylistPage(),
              // TODO: 추후에 메뉴가 추가되면 적용 예정
              // ProfilePage(),
            ],
          ),
        )
      // TODO: 추후에 메뉴가 추가되면 적용 예정
      // bottomNavigationBar: BottomNavigationBar(
      //   items: const <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home),
      //       label: 'Home',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.person),
      //       label: 'Profile',
      //     ),
      //   ],
      //   currentIndex: _selectedIndex,
      //   selectedItemColor: Colors.amber[800],
      //   onTap: _onItemTapped,
      // ),
    );
  }
}