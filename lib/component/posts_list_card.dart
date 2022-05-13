import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constants/text_data.dart';
import '../screens/post_detail_screen.dart';

class PostsListCard extends StatelessWidget {
  const PostsListCard({
    Key? key,
    required this.tittle,
    required this.date,
    required this.rating,
    required this.impression,
    required this.posterUrl,
    required this.uid,
  }) : super(key: key);

  final String tittle;
  final String date;
  final int rating;
  final String impression;
  final String? posterUrl;
  final String uid;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, PostDetailScreen.id, arguments: {
            'uid': uid,
            'tittle': tittle,
            'rating': rating,
            'impression': impression,
            'posterUrl': posterUrl
          });
        },
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
