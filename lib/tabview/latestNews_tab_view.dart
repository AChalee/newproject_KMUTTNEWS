import 'package:New_Project_KMUTTNEWS/screens/news_detail.dart';
import 'package:New_Project_KMUTTNEWS/service/logger_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

import '../constants.dart';

class LatestNewsTabView extends StatefulWidget {
  LatestNewsTabView({Key key, this.newsTitle, this.newsContent})
      : super(key: key);
  final String newsTitle;
  final String newsContent;
  // final News news;

  @override
  _LatestNewsTabViewState createState() => _LatestNewsTabViewState();
}

class _LatestNewsTabViewState extends State<LatestNewsTabView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("News")
              .orderBy('create_at', descending: true)
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
              return ListView.builder(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot item = snapshot.data.documents[index];
                  // return Card(
                  //   child: ListTile(
                  //     onTap: () async {
                  //       await FirebaseFirestore.instance
                  //           .collection("News")
                  //           .doc(item.id)
                  //           .update(
                  //         {'view_count': item['view_count'] + 1},
                  //       );

                  //       await Navigator.pushNamed(
                  //         context,
                  //         NewsDetail.routeName,
                  //         arguments: NewsDetailParams(
                  //           item.id,
                  //           item['title'],
                  //         ),
                  //       );
                  //     },
                  //     title: Text(item['title']),
                  //     subtitle: Text(item['detail']),
                  //   ),
                  // );

                  return InkWell(
                    onTap: () async {
                      await FirebaseFirestore.instance
                          .collection("News")
                          .doc(item.id)
                          .update(
                        {'view_count': item['view_count'] + 1},
                      );
                      await Navigator.pushNamed(
                        context,
                        NewsDetail.routeName,
                        arguments: NewsDetailParams(
                          item.id,
                          item['title'],
                        ),
                        // title: Text(item['title']),
                        // subtitle: Text(item['detail']),
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      height: 135.0,
                      margin:
                          EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 8.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            border: Border.all(color: kGrey3, width: 1.0)),
                        child: Row(
                          children: [
                            // Text(item['title']),
                            // Text(item['detail']),
                            //Image.network(item['picture']),
                            Container(
                              width: 90.0,
                              height: 135.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.0),
                                image: DecorationImage(
                                  image: NetworkImage(item['picture']),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 12.0,
                            ),
                            Expanded(
                                child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 5.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item['title'],
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: kTitleCard,
                                  ),
                                  SizedBox(
                                    height: 4.0,
                                  ),
                                  Text(
                                    item['detail'],
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: kDetailContent,
                                  ),
                                ],
                              ),
                            ))
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
            if (snapshot.hasError) {
              logger.e("Fetch news error : ${snapshot.error.toString()}");
              return Center(
                child: Column(
                  children: <Widget>[
                    Text("Error Something........."),
                  ],
                ),
              );
            }
            return Center(
              child: Column(
                children: <Widget>[
                  Text("No Data........."),
                ],
              ),
            );
          },
        ),
      ),
      //),
    );
  }
}
