import 'package:flutter/material.dart';
import 'package:movicolle/constants/text_data.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movicolle/component/save_name_dialog.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);
  static String id = 'setting_screen';

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  static String name = TextData.defaultNameText;
  final textController = TextEditingController(text: name);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(TextData.settingText),
        titleTextStyle: Theme.of(context)
            .textTheme
            .headline2!
            .copyWith(color: Colors.white),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.0.h, horizontal: 20.0.w),
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundImage: null,
                    backgroundColor: Colors.grey,
                    radius: 40.0.r,
                    child: const Text(TextData.userText),
                  ),
                  SizedBox(width: 5.0.w),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      TextData.changeImageText,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  )
                ],
              ),
              SizedBox(height: 10.0.h),
              const SettingTittle(tittle: TextData.nameText),
              SizedBox(
                height: 5.0.h,
              ),
              TextField(
                controller: textController,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
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
                  name = value;
                },
              ),
              SizedBox(height: 5.0.h),
              Align(
                alignment: Alignment.centerRight,
                child: OutlinedButton(
                  onPressed: () {
                    name = name;
                    showDialog<void>(
                        context: context,
                        builder: (_) {
                          return const SaveNameDialog();
                        });
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.lightBlue),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                    ),
                  ),
                  child: Text(
                    TextData.saveText,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 15.0.h),
              const SettingTittle(tittle: TextData.screenSettingText),
              SizedBox(height: 5.0.h),
              SettingListItem(
                icon: const Icon(Icons.colorize),
                title: TextData.themeColorText,
                onTap: () {},
              ),
              SizedBox(height: 15.0.h),
              const SettingTittle(tittle: TextData.aboutAppText),
              SizedBox(height: 5.0.h),
              SettingListItem(
                icon: const Icon(Icons.email),
                title: TextData.contactText,
                onTap: () {},
              ),
              SizedBox(height: 2.0.h),
              SettingListItem(
                icon: const Icon(Icons.construction),
                title: TextData.defectText,
                onTap: () {},
              ),
              SizedBox(height: 2.0.h),
              SettingListItem(
                icon: const Icon(Icons.assignment_turned_in),
                title: TextData.privacyPolicyText,
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SettingTittle extends StatelessWidget {
  const SettingTittle({
    Key? key,
    required this.tittle,
  }) : super(key: key);

  final String tittle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 5.0.w),
      child: Text(
        tittle,
        style:
            Theme.of(context).textTheme.headline3!.copyWith(color: Colors.grey),
      ),
    );
  }
}

class SettingListItem extends StatelessWidget {
  const SettingListItem({
    Key? key,
    required this.icon,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  final Icon icon;
  final String title;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon,
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyText2,
      ),
      shape: RoundedRectangleBorder(
        side: BorderSide(width: 0.5.w),
        borderRadius: BorderRadius.circular(10.0),
      ),
      trailing: Icon(
        Icons.chevron_right,
        size: 40.0.w,
      ),
      onTap: onTap(),
    );
  }
}
