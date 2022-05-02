import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:movicolle/screens/login_screen.dart';
import 'package:movicolle/screens/mypage_screen.dart';
import 'package:movicolle/screens/post_screen.dart';
import 'package:movicolle/screens/register_screen.dart';
import 'package:movicolle/screens/setting_screen.dart';
import 'package:movicolle/screens/theme_color_screen.dart';
import 'package:movicolle/screens/top_screen.dart';
import 'screens/home_screen_init.dart';
import 'screens/search_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'providers/user_provider.dart';
import 'package:movicolle/providers/theme_color_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<ThemeColorProvider>(
          create: (context) => ThemeColorProvider()),
      ChangeNotifierProvider<UserProvider>(create: (context) => UserProvider()),
    ],
    child: MoviColle(),
  ));
}

class MoviColle extends StatelessWidget {
  MoviColle({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: () {
          final ThemeColorProvider themeColorProvider =
              context.watch<ThemeColorProvider>();
          return MaterialApp(
            theme: ThemeData(
              primarySwatch: themeColorProvider.primaryColor,
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
              ThemeColorScreen.id: (context) => ThemeColorScreen(),
              PostScreen.id: (context) => PostScreen(),
            },
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale("en"),
              Locale("ja"),
            ],
          );
        });
  }
}
