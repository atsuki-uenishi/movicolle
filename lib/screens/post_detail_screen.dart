import 'package:flutter/material.dart';
import 'package:movicolle/constants/text_data.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movicolle/controller/post_controller.dart';
import 'package:movicolle/component/please_enter_dialog.dart';

class PostDetailScreen extends StatefulWidget {
  const PostDetailScreen({Key? key, required this.arguments}) : super(key: key);
  static const String id = 'post_detail_screen';
  final Map<String, dynamic> arguments;

  @override
  PostDetailScreenState createState() => PostDetailScreenState();
}

class PostDetailScreenState extends State<PostDetailScreen> {
  String? _tittle;
  String? _posterUrl;
  int _rating = 1;
  String? _impression;
  String? _uid;

  Future<void> changePost() async {
    if (_tittle == null || _impression == null) {
      showDialog<void>(
          context: context,
          builder: (_) {
            return const PleaseEnterDialog();
          });
      return;
    }
    await PostController().changePostData(_rating, _impression!, _uid!);
    Navigator.pop(context);
  }

  Future<void> deletePost() async {
    await PostController().deletePostData(_uid!);
  }

  void setData(Map<String, dynamic> arguments) {
    _uid = arguments['uid'];
    _tittle = arguments['tittle'];
    _rating = arguments['rating'];
    _posterUrl = arguments['posterUrl'];
    _impression = arguments['impression'];
  }

  @override
  void initState() {
    super.initState();

    setData(widget.arguments);
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
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 25.0.h, horizontal: 10.0.w),
        child: ListView(children: [
          Column(
            children: [
              SizedBox(height: 20.0.h),
              Text(
                TextData.tittleScreenText,
                style: Theme.of(context).textTheme.headline5,
              ),
              SizedBox(height: 10.0.h),
              SizedBox(
                width: 300.0.w,
                child: Center(
                  child: Text(
                    _tittle!,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
              ),
              SizedBox(height: 10.0.h),
              _posterUrl != null
                  ? Image.network(
                      _posterUrl!,
                      height: 100.0.h,
                    )
                  : const SizedBox(height: 0),
              SizedBox(height: 10.0.h),
              Text(TextData.ratingScreenText,
                  style: Theme.of(context).textTheme.headline5),
              SizedBox(height: 10.0.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 30.0.h,
                    width: 30.0.w,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          if (_rating == 1) {
                            return;
                          }
                          _rating -= 1;
                        });
                      },
                      child: const Icon(
                        Icons.remove,
                        color: Colors.white,
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero,
                        fixedSize: Size(10.0.w, 10.0.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15.0.r),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10.0.w,
                  ),
                  Row(
                    children: [
                      for (int index = 1; index < 6; index++)
                        Icon(
                          Icons.star,
                          color: _rating >= index ? Colors.yellow : Colors.grey,
                          size: 40.0,
                        ),
                    ],
                  ),
                  SizedBox(
                    width: 10.0.w,
                  ),
                  SizedBox(
                    height: 30.0.h,
                    width: 30.0.w,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          if (_rating == 5) {
                            return;
                          }
                          _rating += 1;
                        });
                      },
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero,
                        fixedSize: Size(10.0.w, 10.0.h),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0.r))),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15.0.h),
              Text(TextData.impressionScreenText,
                  style: Theme.of(context).textTheme.headline5),
              SizedBox(height: 10.0.h),
              SizedBox(
                width: 300.0.w,
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: 4,
                  controller: TextEditingController(text: _impression),
                  onChanged: (value) {
                    _impression = value;
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
                      )),
                ),
              ),
              SizedBox(height: 20.0.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    icon: const Icon(
                      Icons.change_circle,
                      color: Colors.white,
                    ),
                    label: const Text(TextData.changeText),
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
                      changePost();
                    },
                  ),
                  SizedBox(width: 10.0.w),
                  ElevatedButton.icon(
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                    label: const Text(TextData.deleteText),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                          vertical: 10.0.h, horizontal: 20.0.w),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0.r),
                        ),
                      ),
                    ),
                    onPressed: () async {
                      await deletePost();
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
