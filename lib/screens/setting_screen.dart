import 'package:flutter/material.dart';
import 'package:movicolle/constants/text_data.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'theme_color_screen.dart';
import 'package:provider/provider.dart';
import 'package:movicolle/providers/user_provider.dart';
import 'package:movicolle/model/user_model.dart';
import 'package:movicolle/controller/firestorage_controller.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);
  static String id = 'setting_screen';

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  static String name = TextData.defaultNameText;
  final textController = TextEditingController(text: name);
  final ImagePicker picker = ImagePicker();

  Future<void> _getImageFromGallery(UserModel userModel) async {
    final _pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 50,
        preferredCameraDevice: CameraDevice.front);
    if (_pickedFile != null) {
      FireStorageController.uploadFile(_pickedFile.path, _pickedFile.name);
      await FireStorageController.addFilePath(userModel.uid, _pickedFile.path,
          ('${TextData.imagesText}/${_pickedFile.name}'));
      WidgetsBinding.instance!.addPostFrameCallback(
          (_) => context.read<UserProvider>().fetchUserData());
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = context.read<UserProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text(TextData.settingText),
        titleTextStyle: Theme.of(context)
            .textTheme
            .headline2!
            .copyWith(color: Colors.white),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.0.h, horizontal: 20.0.w),
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  UserIcon(),
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

class UserIcon extends StatelessWidget {
  const UserIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserModel? userData =
        context.select((UserProvider user) => user.userModel);
    return FutureBuilder(
        future: FireStorageController.getImgs(
            userData!.localPath!, userData.remotePath!),
        builder:
            (BuildContext context, AsyncSnapshot<ImageProvider?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          if (snapshot.hasData) {
            return CircleAvatar(
              backgroundImage: snapshot.data,
              backgroundColor: Colors.grey,
              radius: 50.0.r,
            );
          }
          return CircleAvatar(
            backgroundImage: null,
            backgroundColor: Colors.grey,
            radius: 50.0.r,
          );
        });
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
