import 'package:flutter/material.dart';
import 'package:movicolle/constants/text_data.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:movicolle/providers/theme_color_provider.dart';

class ThemeColorScreen extends StatefulWidget {
  const ThemeColorScreen({Key? key}) : super(key: key);

  static String id = 'theme_color_screen';

  @override
  _ThemeColorScreenState createState() => _ThemeColorScreenState();
}

class _ThemeColorScreenState extends State<ThemeColorScreen> {
  @override
  Widget build(BuildContext context) {
    final ThemeColorProvider themeColorProvider =
        context.read<ThemeColorProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          TextData.themeColorText,
          style: Theme.of(context)
              .textTheme
              .headline2!
              .copyWith(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            Center(
              child: Row(
                children: [
                  Text(TextData.chooseThemeColorText,
                      style: Theme.of(context).textTheme.bodyText2),
                  SizedBox(
                    width: 10.0.w,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: themeColorProvider.primaryColor!,
                      shape: const CircleBorder(),
                    ),
                    onPressed: () {},
                    child: null,
                  )
                ],
              ),
            ),
            SizedBox(height: 20.0.h),
            Column(
              children: [
                Row(
                  children: [
                    const _ColorCircle(
                      color: Colors.red,
                    ),
                    SizedBox(width: 20.0.h),
                    const _ColorCircle(
                      color: Colors.blue,
                    ),
                    SizedBox(width: 20.0.h),
                    const _ColorCircle(
                      color: Colors.yellow,
                    ),
                  ],
                ),
                SizedBox(height: 20.0.h),
                Row(
                  children: [
                    const _ColorCircle(
                      color: Colors.green,
                    ),
                    SizedBox(width: 20.0.h),
                    const _ColorCircle(
                      color: Colors.purple,
                    ),
                    SizedBox(width: 20.0.h),
                    const _ColorCircle(
                      color: Colors.orange,
                    ),
                  ],
                ),
                SizedBox(height: 20.0.h),
                Row(
                  children: [
                    const _ColorCircle(
                      color: Colors.pink,
                    ),
                    SizedBox(width: 20.0.h),
                    const _ColorCircle(
                      color: Colors.brown,
                    ),
                    SizedBox(width: 20.0.h),
                    const _ColorCircle(
                      color: Colors.grey,
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _ColorCircle extends StatelessWidget {
  const _ColorCircle({
    Key? key,
    required this.color,
  }) : super(key: key);
  final MaterialColor color;

  @override
  Widget build(BuildContext context) {
    final ThemeColorProvider themeColorProvider =
        context.read<ThemeColorProvider>();
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: color,
        shape: CircleBorder(),
        fixedSize: Size(90.0.w, 90.0.h),
      ),
      onPressed: () {
        themeColorProvider.setColor(color);
      },
      child: null,
    );
  }
}
