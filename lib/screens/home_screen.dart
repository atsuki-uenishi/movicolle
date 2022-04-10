import 'package:flutter/material.dart';
import 'search_screen.dart';
import 'mypage_screen.dart';
import 'setting_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movicolle/textdata.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static String id = 'home_screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final _pages = <Widget>[
    MyPageScreen(),
    SearchScreen(),
    SettingScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height,
        maxWidth: MediaQuery.of(context).size.width,
      ),
      designSize: Size(360, 690),
      context: context,
      minTextAdapt: true,
    );

    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/images/logo.png',
          height: 60.0.h,
          width: 60.0.w,
        ),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.grey[100],
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: TextData.homeText,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: TextData.searchText,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: TextData.searchText,
          ),
        ],
      ),
    );
  }
}
