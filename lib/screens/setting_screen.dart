import 'package:flutter/material.dart';
import 'package:movicolle/constants/text_data.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'theme_color_screen.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:movicolle/providers/user_provider.dart';
import 'package:movicolle/model/user_model.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);
  static String id = 'setting_screen';

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  static String name = TextData.defaultNameText;
  final textController = TextEditingController(text: name);
  Image? _image;
  final ImagePicker picker = ImagePicker();
  UserProvider? user;

  Future<void> _getImageFromGallery(UserModel userModel) async {
    final _pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 50,
        preferredCameraDevice: CameraDevice.front);
    if (_pickedFile != null) {
      _uploadFile(_pickedFile.path, _pickedFile.name);
      _addFilePath(userModel.uid, _pickedFile.path,
          ('${TextData.imagesText}/${_pickedFile.name}'));
      _getImgs(
          _pickedFile.path, ('${TextData.imagesText}/${_pickedFile.name}'));
    }
  }

  Future<void> _uploadFile(String sourcePath, String uploadFileName) async {
    final FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref =
        storage.ref().child(TextData.imagesText).child('/$uploadFileName');
    File file = File(sourcePath);

    try {
      await ref.putFile(file);
    } catch (FirebaseException) {
      print(FirebaseException);
    }
  }

  Future<void> _addFilePath(
      String? userId, String localPath, String remotePath) async {
    CollectionReference users =
        FirebaseFirestore.instance.collection(TextData.usersText);
    await users.doc(userId).set({
      TextData.localPathText: localPath,
      TextData.remotePathText: remotePath,
    }, SetOptions(merge: true));
  }

  Future<void> _getImgs(String? imgPathLocal, String? imgPathRemote) async {
    String? imgPathUse;
    if (imgPathLocal != null) {
      bool existLocal = await File(imgPathLocal).existsSync();
      if (existLocal) {
        imgPathUse = imgPathLocal;
        _image = Image.file(File(imgPathUse));
      } else if (imgPathRemote != null) {
        try {
          imgPathUse = await FirebaseStorage.instance
              .ref()
              .child(TextData.imagesText)
              .child(imgPathRemote)
              .getDownloadURL();
          _image = Image.network(imgPathUse);
        } catch (FirebaseException) {
          imgPathUse = null;
        }
      } else {
        imgPathUse = null;
      }
    }
    setState(() {});
  }

  // @override
  // void initState() {
  //   super.initState();
  //   final user = context.read<UserProvider>();
  //   _getImgs(user.userModel?.localPath, user.userModel?.remotePath);
  // }

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = context.watch<UserProvider>();
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
                    backgroundImage: _image?.image,
                    backgroundColor: Colors.grey,
                    radius: 50.0.r,
                  ),
                  SizedBox(width: 5.0.w),
                  TextButton(
                    onPressed: () {
                      _getImageFromGallery(userProvider.userModel!);
                    },
                    child: Text(
                      TextData.changeImageText,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  )
                ],
              ),
              SizedBox(height: 10.0.h),
              const _SettingTittle(tittle: TextData.nameText),
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
              SizedBox(height: 15.0.h),
              const _SettingTittle(tittle: TextData.screenSettingText),
              SizedBox(height: 5.0.h),
              _SettingListItem(
                icon: const Icon(Icons.colorize),
                title: TextData.themeColorText,
                onTap: () {
                  Navigator.pushNamed(context, ThemeColorScreen.id);
                },
              ),
              SizedBox(height: 15.0.h),
              const _SettingTittle(tittle: TextData.aboutAppText),
              SizedBox(height: 5.0.h),
              _SettingListItem(
                icon: const Icon(Icons.email),
                title: TextData.contactText,
                onTap: () {},
              ),
              SizedBox(height: 2.0.h),
              _SettingListItem(
                icon: const Icon(Icons.construction),
                title: TextData.defectText,
                onTap: () {},
              ),
              SizedBox(height: 2.0.h),
              _SettingListItem(
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

class _SettingTittle extends StatelessWidget {
  const _SettingTittle({
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

class _SettingListItem extends StatelessWidget {
  const _SettingListItem({
    Key? key,
    required this.icon,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  final Icon icon;
  final String title;
  final Function() onTap;

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
      onTap: onTap,
    );
  }
}
