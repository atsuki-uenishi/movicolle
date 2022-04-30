import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movicolle/screens/post_screen.dart';

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
      appBar: AppBar(
        title: Image.asset(
          'assets/images/logo.png',
          height: 60.0.h,
          width: 60.0.w,
        ),
        automaticallyImplyLeading: false,
      ),
      body: Text('mypage'),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 15.0, bottom: 20.0),
        child: Container(
          width: 60.0.w,
          height: 60.0.h,
          child: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, PostScreen.id);
            },
          ),
        ),
      ),
    );
  }
}
