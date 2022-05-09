import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movicolle/constants/text_data.dart';
import 'package:movicolle/screens/post_screen.dart';
import 'package:movicolle/controller/get_data_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyPageScreen extends StatefulWidget {
  const MyPageScreen({Key? key}) : super(key: key);
  static String id = 'mypage_screen';

  @override
  _MyPageScreenState createState() => _MyPageScreenState();
}

class _MyPageScreenState extends State<MyPageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/images/logo.png',
          height: 60.0.h,
          width: 60.0.w,
        ),
        automaticallyImplyLeading: false,
      ),
      body: DataStream(),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 15.0, bottom: 20.0),
        child: Container(
          width: 60.0.w,
          height: 60.0.h,
          child: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, PostScreen.id);
            },
          ),
        ),
      ),
    );
  }
}

class DataStream extends StatelessWidget {
  DataStream({Key? key}) : super(key: key);
  final Stream<QuerySnapshot<Object?>>? stream = GetDataController().getData();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: stream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }
        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> post =
                document.data()! as Map<String, dynamic>;
            return PostList(
              tittle: post[TextData.tittleText],
              date: post[TextData.dateText],
              rating: post[TextData.ratingText],
              impression: post[TextData.impressionText],
              posterUrl: post[TextData.posterUrlText],
            );
          }).toList(),
        );
      },
    );
  }
}

class PostList extends StatelessWidget {
  const PostList(
      {Key? key,
      required this.tittle,
      required this.date,
      required this.rating,
      required this.impression,
      required this.posterUrl})
      : super(key: key);

  final String tittle;
  final String date;
  final int rating;
  final String impression;
  final String? posterUrl;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: InkWell(
        onTap: () {},
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0.r),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    tittle,
                    style: Theme.of(context).textTheme.bodyText2,
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
                SizedBox(height: 5.0.h),
                Row(
                  children: [
                    for (int index = 1; index <= rating; index++)
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                        size: 20.0.w,
                      ),
                  ],
                ),
                SizedBox(
                  height: 10.0.h,
                ),
                Row(
                  children: [
                    posterUrl != null
                        ? Image.network(
                            posterUrl!,
                            height: 150.0.h,
                          )
                        : Container(
                            height: 150.0.h,
                            width: 120.0.w,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                            ),
                            alignment: Alignment.center,
                            child: const Text(TextData.noImageText),
                          ),
                    SizedBox(
                      width: 10.0.w,
                    ),
                    Flexible(
                      child: Text(
                        impression,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(height: 1.2.h),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 4,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5.0.h,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    date,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(color: Colors.grey),
                    textAlign: TextAlign.right,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
