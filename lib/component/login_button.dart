import 'package:flutter/material.dart';
import 'package:movicolle/screens/home_screen_init.dart';
import 'package:movicolle/text_data.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movicolle/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movicolle/component/error_dialog.dart';

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
        onPressed: () async {
          FirebaseAuthModel firebaseAuthModel = FirebaseAuthModel();
          final User? user = await firebaseAuthModel.signWithGoogle();
          if (user != null) {
            Navigator.pushNamed(context, HomeScreen.id);
            return;
          }
          showDialog<void>(
              context: context,
              builder: (_) {
                return ErrorDialog();
              });
          //print(user);
        },
        child: Text(
          TextData.loginText,
          style:
              Theme.of(context).textTheme.button?.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
