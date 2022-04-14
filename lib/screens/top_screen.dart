import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'register_screen.dart';
import 'package:movicolle/text_data.dart';
import 'package:movicolle/component/register_button.dart';
import 'package:movicolle/component/login_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TopScreen extends StatelessWidget {
  static String id = 'top_screen';
  const TopScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/topBG.jpg"),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Color.fromRGBO(255, 255, 255, 0.3),
                  BlendMode.srcATop,
                )),
          ),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Image(
                  image: AssetImage("assets/images/logo.png"),
                ),
                LoginButton(),
                // SizedBox(
                //   height: 30.0.h,
                // ),
                // RegisterButton(),
              ],
            ),
          )),
    );
  }
}
