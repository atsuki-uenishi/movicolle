import 'package:flutter/material.dart';
import 'package:movicolle/constants/text_data.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:movicolle/controller/post_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movicolle/component/post_done_dialog.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);
  static String id = 'post_screen';

  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  static DateTime dateNow = DateTime.now();
  static DateFormat outputFormat = DateFormat('yyyy-MM-dd');
  String _date = outputFormat.format(dateNow);
  String? _tittle;
  String? _posterUrl;
  int? _rating;
  String? _impression;

  void dateButton() async {
    final DateTime? picked = await showDatePicker(
        locale: const Locale('ja'),
        context: context,
        initialDate: dateNow,
        firstDate: DateTime(2020),
        lastDate: DateTime.now().add(const Duration(days: 360)));

    if (picked != null) {
      setState(() {
        _date = outputFormat.format(picked);
      });
    }
  }

  void post() async {
    final String? userId = FirebaseAuth.instance.currentUser?.uid;
    await PostController()
        .postData(userId!, _tittle!, _date, _rating!, _impression!, _posterUrl);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 100.0.w,
        leading: TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            TextData.cancelText,
            style: Theme.of(context)
                .textTheme
                .headline3!
                .copyWith(color: Colors.white),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(TextData.postText,
                style: Theme.of(context)
                    .textTheme
                    .headline3!
                    .copyWith(color: Colors.white)),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Text(TextData.tittleText),
            TextField(
              onChanged: (value) {
                _tittle = value;
              },
            ),
            TextButton(onPressed: dateButton, child: Text(TextData.dateText)),
            Text("${_date}"),
            Text(TextData.ratingText),
            TextField(
              onChanged: (value) {
                _rating = int.parse(value);
              },
            ),
            Text(TextData.impressionText),
            TextField(
              onChanged: (value) {
                _impression = value;
              },
            ),
            TextButton(
              onPressed: post,
              child: Text(TextData.postText),
            )
          ],
        ),
      ),
    );
  }
}
