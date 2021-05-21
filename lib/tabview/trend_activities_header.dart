//import 'dart:html';

import 'package:New_Project_KMUTTNEWS/constants.dart';
import 'package:New_Project_KMUTTNEWS/screens/activities_detail.dart';
import 'package:New_Project_KMUTTNEWS/service/logger_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TrendActivitiesHeader extends StatefulWidget {
  @override
  _TrendActivitiesHeaderState createState() => _TrendActivitiesHeaderState();
}

class _TrendActivitiesHeaderState extends State<TrendActivitiesHeader> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("Activities")
          .where('view_count', isGreaterThan: 5)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Column(
              children: <Widget>[
                CircularProgressIndicator(),
                Text("Loading........."),
              ],
            ),
          );
        }
        if (snapshot.hasData && snapshot.data.documents.length > 0) {
          return Container(
            height: 250,
            child: ListView.builder(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  final item = snapshot.data.documents[index];
                  return InkWell(
                    onTap: () async {
                      await FirebaseFirestore.instance
                          .collection("Activities")
                          .doc(item.id)
                          .update(
                        {'view_count': item['view_count'] + 1},
                      );
                      await Navigator.pushNamed(
                        context,
                        ActivitiesDatail.routeName,
                        arguments: ActivitiesDatailParams(
                          item.id,
                          item['title'],
                        ),
                      );
                    },
                    child: Container(
                      width: 300.0,
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 24.0),
                      decoration: BoxDecoration(
                          border: Border.all(color: kGrey3, width: 1.0),
                          borderRadius: BorderRadius.circular(15.0)),
                      margin: EdgeInsets.fromLTRB(10, 15, 10, 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Row(
                          //   children: [
                          //     CircleAvatar(
                          //       radius: 5.0,
                          //       backgroundColor: kGrey1,
                          //     ),
                          //     SizedBox(
                          //       width: 10.0,
                          //     ),
                          //     Text(
                          //       item['title'],
                          //       style: kCategoryTitle,
                          //     )
                          //   ],
                          // ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                  image: NetworkImage(item['picture']),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            // child: Hero(
                            //   tag: item['view_count'],
                            //   child: Container(
                            //     decoration: BoxDecoration(
                            //       borderRadius: BorderRadius.circular(15),
                            //       image: DecorationImage(
                            //         image: NetworkImage(item['picture']),
                            //         fit: BoxFit.cover,
                            //       ),
                            //     ),
                            //   ),
                            // ),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          // Expanded(
                          //     child: Text(
                          //   item['title'],
                          //   overflow: TextOverflow.ellipsis,
                          //   maxLines: 2,
                          //   style: kTitleCard,
                          // )),
                          Text(
                            item['title'],
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: kTitleCard,
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Row(
                            children: [
                              Expanded(
                                  child: Text(
                                item['detail'],
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: kDetailContent,
                              ))
                              // Text(
                              //   item['detail'],
                              //   overflow: TextOverflow.ellipsis,
                              //   maxLines: 2,
                              //   style: kDetailContent,
                              // )
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          );
        }
        if (snapshot.hasError) {
          logger.e("Fetch activities erorr : ${snapshot.error.toString()}");
          return Center(
            child: Column(
              children: <Widget>[Text("Error Something.........")],
            ),
          );
        }
        return Container();
      },
    );
  }
}
