import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movicolle/constants/text_data.dart';
import 'package:movicolle/screens/post_screen.dart';
import 'package:movicolle/controller/get_data_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../component/posts_list_card.dart';

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
  final Stream<QuerySnapshot<Object?>>? stream =
      GetDataController().getDataStream();

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
            final String uid = document.id;
            return PostsListCard(
              uid: uid,
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
