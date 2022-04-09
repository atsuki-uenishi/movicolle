import 'package:flutter/material.dart';

class MyPageScreen extends StatefulWidget {
  const MyPageScreen({Key? key}) : super(key: key);
  static String id = 'mypage_screen';

  @override
  _MyPageScreenState createState() => _MyPageScreenState();
}

class _MyPageScreenState extends State<MyPageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('mypage'),
    );
  }
}
