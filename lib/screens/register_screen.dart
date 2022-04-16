import 'package:flutter/material.dart';
import 'package:movicolle/constants/text_data.dart';
import 'package:movicolle/component/register_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);
  static String id = 'register_screen';

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String email = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              TextData.registerText,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 40.0.sp,
                color: Colors.black,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: Text(
                      TextData.emailText,
                      textAlign: TextAlign.left,
                    ),
                  ),
                  TextField(
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Password',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                    onChanged: (value) {
                      email = value;
                    },
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: Text(
                      TextData.passwordText,
                    ),
                  ),
                  TextField(
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: TextData.passwordText,
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                    onChanged: (value) {
                      password = value;
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 25.0.h,
            ),
            RegisterButton(),
          ],
        ),
      ),
    );
  }
}
