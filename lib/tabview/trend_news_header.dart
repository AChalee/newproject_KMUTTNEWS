import 'package:New_Project_KMUTTNEWS/constants.dart';
import 'package:New_Project_KMUTTNEWS/screens/news_detail.dart';
import 'package:New_Project_KMUTTNEWS/service/logger_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TrendNewsHeader extends StatefulWidget {
  @override
  _TrendNewsHeaderState createState() => _TrendNewsHeaderState();
}

class _TrendNewsHeaderState extends State<TrendNewsHeader> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("News")
          .where('view_count', isGreaterThan: 50)
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
                          item['picture']
                      ),
                    );
                  },
                  child: Container(
                    width: 300.0,
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: kGrey3, width: 1.0),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    margin: EdgeInsets.fromLTRB(10, 15, 10, 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 5.0,
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                  image: NetworkImage(item['picture']),
                                  fit: BoxFit.cover),
                            ),
                          ),
                          // child: Hero(
                          //   tag: item['view_count'],
                          //   child: Container(
                          //     decoration: BoxDecoration(
                          //       borderRadius: BorderRadius.circular(15),
                          //       image: DecorationImage(
                          //           image: NetworkImage(item['picture']),
                          //           fit: BoxFit.cover),
                          //     ),
                          //   ),
                          // ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
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
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
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
        return Container();
      },
    );
  }
}
