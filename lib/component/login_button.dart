import 'package:flutter/material.dart';
import 'package:movicolle/text_data.dart';
import 'package:movicolle/screens/login_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height,
        maxWidth: MediaQuery.of(context).size.width,
      ),
      designSize: const Size(360, 690),
      context: context,
      minTextAdapt: true,
    );

    return SizedBox(
      width: 300.0.w,
      height: 70.0.h,
      child: OutlinedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.lightGreen),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
          ),
        ),
        onPressed: () {
          Navigator.pushNamed(
            context,
            LoginScreen.id,
          );
        },
        child: Text(
          TextData.loginText,
          style: TextStyle(
            color: Colors.white,
            fontSize: 30.0.sp,
          ),
        ),
      ),
    );
  }
}
