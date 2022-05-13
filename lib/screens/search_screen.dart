import 'package:flutter/material.dart';
import 'package:movicolle/component/posts_list_card.dart';
import 'package:movicolle/constants/text_data.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movicolle/controller/get_data_controller.dart';
import 'package:provider/provider.dart';

import '../providers/theme_color_provider.dart';
import '../switch_color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SearchScreen extends StatefulWidget {
  static const String id = "search_screen";

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String? _searchTittle;
  List<Map<String, dynamic>> _searchList = [];
  List<Map<String, dynamic>> _postsList = [];

  Future<void> getPostsData() async {
    _postsList = await GetDataController().getData();
  }

  Future<void> tittleSearch() async {
    _searchList.clear();
    for (var post in _postsList) {
      _searchList.add(post);
    }
    _searchList.removeWhere((dynamic postValue) =>
        postValue['tittle'].contains(_searchTittle) == false);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getPostsData();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeColorProvider themeColorProvider =
        context.watch<ThemeColorProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          TextData.searchText,
          style: Theme.of(context)
              .textTheme
              .headline1!
              .copyWith(color: Colors.white),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.0.h, horizontal: 10.0.w),
        child: ListView(
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
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 2.0)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15.0.r),
                              bottomLeft: Radius.circular(15.0.r)),
                          borderSide: BorderSide(
                            color: SwitchColor.switchColor(
                                themeColorProvider.primaryColor),
                            width: 2.0,
                          )),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40.0.h,
                  child: ElevatedButton(
                    onPressed: () {
                      tittleSearch();
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
            for (var post in _searchList)
              PostsListCard(
                  tittle: post['tittle'],
                  date: post['date'],
                  rating: post['rating'],
                  impression: post['impression'],
                  posterUrl: post['posterUrl'],
                  uid: post['uid']),
          ],
        ),
      ),
    );
  }
}
