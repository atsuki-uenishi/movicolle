import 'package:flutter/material.dart';
import 'package:movicolle/constants/text_data.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:movicolle/controller/email_controller.dart';

import '../providers/theme_color_provider.dart';
import '../switch_color.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({Key? key}) : super(key: key);
  static const String id = 'contact_screen';

  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  String? contents;

  @override
  Widget build(BuildContext context) {
    final ThemeColorProvider themeColorProvider =
        context.watch<ThemeColorProvider>();
    return Scaffold(
        appBar: AppBar(
          title: Text(
            TextData.contactText,
            style: Theme.of(context)
                .textTheme
                .headline1!
                .copyWith(color: Colors.white),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 30.0.h, horizontal: 20.0.w),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                child: Text(
                  TextData.contentsText,
                  style: Theme.of(context).textTheme.headline2,
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(
                height: 10.0.h,
              ),
              SizedBox(
                width: 300.0.w,
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: 8,
                  onChanged: (value) {
                    contents = value;
                  },
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(10.0),
                      enabledBorder: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(15.0.r)),
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 1.0)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0.r)),
                        borderSide: BorderSide(
                            color: SwitchColor.switchColor(
                                themeColorProvider.primaryColor),
                            width: 1.0),
                      )),
                ),
              ),
              SizedBox(height: 20.0.h),
              ElevatedButton.icon(
                icon: const Icon(
                  Icons.send,
                  color: Colors.white,
                ),
                label: const Text(TextData.sendText),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                      vertical: 10.0.h, horizontal: 20.0.w),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0.r),
                    ),
                  ),
                ),
                onPressed: () {
                  EmailController().sendMail(contents);
                },
              ),
            ],
          ),
        ));
  }
}
