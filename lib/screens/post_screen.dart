import 'package:flutter/material.dart';
import 'package:movicolle/constants/text_data.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:movicolle/controller/post_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movicolle/providers/theme_color_provider.dart';
import 'package:movicolle/screens/api_results_screen.dart';
import 'package:provider/provider.dart';
import 'package:movicolle/component/please_enter_dialog.dart';
import 'package:movicolle/controller/tmdb_api_controller.dart';
import 'package:movicolle/component/error_dialog.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);
  static const String id = 'post_screen';

  @override
  PostScreenState createState() => PostScreenState();
}

class PostScreenState extends State<PostScreen> {
  static final DateTime _dateNow = DateTime.now();
  static final DateFormat _outputFormat = DateFormat('yyyy-MM-dd');
  String _date = _outputFormat.format(_dateNow);
  String? _tittle;
  String? _posterUrl;
  int _rating = 1;
  String? _impression;
  String? _searchTittle;

  void dateButton() async {
    final DateTime? picked = await showDatePicker(
        locale: const Locale('ja'),
        context: context,
        initialDate: _dateNow,
        firstDate: DateTime(2020),
        lastDate: DateTime.now().add(const Duration(days: 360)));

    if (picked != null) {
      setState(() {
        _date = _outputFormat.format(picked);
      });
    }
  }

  Future<void> post() async {
    if (_tittle == null || _impression == null) {
      showDialog<void>(
          context: context,
          builder: (_) {
            return const PleaseEnterDialog();
          });
      return;
    }
    final String? userId = FirebaseAuth.instance.currentUser?.uid;
    await PostController()
        .postData(userId!, _tittle!, _date, _rating, _impression!, _posterUrl);
    Navigator.pop(context);
  }

  Color switchColor(MaterialColor? color) {
    if (color == Colors.red) {
      return Colors.red;
    } else if (color == Colors.blue) {
      return Colors.blue;
    } else if (color == Colors.yellow) {
      return Colors.yellow;
    } else if (color == Colors.green) {
      return Colors.green;
    } else if (color == Colors.purple) {
      return Colors.purple;
    } else if (color == Colors.orange) {
      return Colors.orange;
    } else if (color == Colors.pink) {
      return Colors.pink;
    } else if (color == Colors.brown) {
      return Colors.brown;
    } else if (color == Colors.blue) {
      return Colors.grey;
    } else {
      return Colors.blue;
    }
  }

  Future<void> searchApi() async {
    if (_searchTittle == null) {
      showDialog<void>(
          context: context,
          builder: (_) {
            return const ErrorDialog();
          });
      return;
    }
    List<Map<String, dynamic>> _apiResults =
        await TMDBApiController().getTMDBApi(_searchTittle!);
    final Map<String, dynamic> result = await Navigator.pushNamed(
            context, ApiResultsScreen.id, arguments: _apiResults)
        as Map<String, dynamic>;
    setState(() {
      _tittle = result['tittle'];
      _posterUrl = result['posterUrl'];
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeColorProvider themeColorProvider =
        context.watch<ThemeColorProvider>();
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 250.0.w,
                    child: TextField(
                      onChanged: (value) {
                        _searchTittle = value;
                      },
                      style: Theme.of(context).textTheme.bodyText2,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(10.0),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15.0.r),
                                  bottomLeft: Radius.circular(15.0.r)),
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 2.0)),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15.0.r),
                                bottomLeft: Radius.circular(15.0.r)),
                            borderSide: BorderSide(
                                color: switchColor(
                                    themeColorProvider.primaryColor),
                                width: 2.0),
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 40.0.h,
                    child: ElevatedButton(
                      onPressed: () {
                        searchApi();
                      },
                      child: const Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(15.0.r),
                            bottomRight: Radius.circular(15.0.r),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.0.h),
              TextButton(
                onPressed: dateButton,
                child: Text(
                  _date,
                  style: Theme.of(context).textTheme.headline5!.copyWith(
                        color: switchColor(themeColorProvider.primaryColor),
                      ),
                ),
              ),
              SizedBox(height: 10.0.h),
              Text(
                TextData.tittleScreenText,
                style: Theme.of(context).textTheme.headline5,
              ),
              SizedBox(
                width: 300.0.w,
                child: TextField(
                  controller: TextEditingController(text: _tittle),
                  onChanged: (value) {
                    _tittle = value;
                  },
                ),
              ),
              SizedBox(height: 10.0.h),
              _posterUrl != null
                  ? Image.network(
                      _posterUrl!,
                      height: 100.0.h,
                    )
                  : SizedBox(height: 0),
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
                      Icon(
                        Icons.star,
                        color: _rating >= 1 ? Colors.yellow : Colors.grey,
                        size: 40.0,
                      ),
                      Icon(
                        Icons.star,
                        color: _rating >= 2 ? Colors.yellow : Colors.grey,
                        size: 40.0,
                      ),
                      Icon(
                        Icons.star,
                        color: _rating >= 3 ? Colors.yellow : Colors.grey,
                        size: 40.0,
                      ),
                      Icon(
                        Icons.star,
                        color: _rating >= 4 ? Colors.yellow : Colors.grey,
                        size: 40.0,
                      ),
                      Icon(
                        Icons.star,
                        color: _rating >= 5 ? Colors.yellow : Colors.grey,
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
              SizedBox(
                width: 300.0.w,
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: 4,
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
                        borderSide: BorderSide(
                            color: switchColor(themeColorProvider.primaryColor),
                            width: 1.0),
                      )),
                ),
              ),
              SizedBox(height: 15.0.h),
              ElevatedButton.icon(
                icon: const Icon(
                  Icons.send,
                  color: Colors.white,
                ),
                label: const Text(TextData.postScreenText),
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
                  post();
                },
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
