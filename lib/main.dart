import 'package:flutter/material.dart';
import 'package:movicolle/screens/login_screen.dart';
import 'package:movicolle/screens/mypage_screen.dart';
import 'package:movicolle/screens/register_screen.dart';
import 'package:movicolle/screens/setting_screen.dart';
import 'package:movicolle/screens/top_screen.dart';
import 'screens/home_screen_init.dart';
import 'screens/search_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MoviColle());
}

class MoviColle extends StatelessWidget {
  const MoviColle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: () => MaterialApp(
        theme: ThemeData(
          textTheme: TextTheme(
            headline1: TextStyle(fontSize: 24.0.sp),
            headline2: TextStyle(fontSize: 20.0.sp),
            headline3: TextStyle(fontSize: 14.0.sp),
            headline4: TextStyle(fontSize: 24.0.sp),
            headline5: TextStyle(fontSize: 18.0.sp),
            headline6: TextStyle(fontSize: 10.0.sp),
            subtitle1: TextStyle(fontSize: 16.0.sp),
            subtitle2: TextStyle(fontSize: 14.0.sp),
            bodyText1: TextStyle(fontSize: 16.0.sp),
            bodyText2: TextStyle(fontSize: 14.0.sp),
            button: TextStyle(fontSize: 24.0.sp),
          ),
        ),
        initialRoute: TopScreen.id,
        routes: {
          TopScreen.id: (context) => TopScreen(),
          RegisterScreen.id: (context) => RegisterScreen(),
          LoginScreen.id: (context) => LoginScreen(),
          HomeScreen.id: (context) => HomeScreen(),
          SearchScreen.id: (context) => SearchScreen(),
          MyPageScreen.id: (context) => MyPageScreen(),
          SettingScreen.id: (context) => SearchScreen(),
        },
      ),
    );
  }
}
