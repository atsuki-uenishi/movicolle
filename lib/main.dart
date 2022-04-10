import 'package:flutter/material.dart';
import 'package:movicolle/screens/mypage_screen.dart';
import 'package:movicolle/screens/setting_screen.dart';
import 'screens/home_screen.dart';
import 'screens/search_screen.dart';

void main() => runApp(MoviColle());

class MoviColle extends StatelessWidget {
  const MoviColle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: HomeScreen.id,
      routes: {
        HomeScreen.id: (context) => HomeScreen(),
        SearchScreen.id: (context) => SearchScreen(),
        MyPageScreen.id: (context) => MyPageScreen(),
        SettingScreen.id: (context) => SearchScreen(),
      },
    );
  }
}
