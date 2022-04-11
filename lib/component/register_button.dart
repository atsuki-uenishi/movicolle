import 'package:flutter/material.dart';
import 'package:movicolle/text_data.dart';
import 'package:movicolle/screens/register_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterButton extends StatelessWidget {
  const RegisterButton({
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
          backgroundColor: MaterialStateProperty.all(Colors.black),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
          ),
          side: MaterialStateProperty.all(
            const BorderSide(color: Colors.lightGreen),
          ),
        ),
        onPressed: () {
          Navigator.pushNamed(
            context,
            RegisterScreen.id,
          );
        },
        child: Text(
          TextData.registerText,
          style: TextStyle(
            color: Colors.white,
            fontSize: 30.0.sp,
          ),
        ),
      ),
    );
  }
}
