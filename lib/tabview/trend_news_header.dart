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
                return Container(
                  width: 250,
                  margin: EdgeInsets.all(8),
                  child: ListTile(
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
                      );
                    },
                    title: Text(item['title']),
                    subtitle: Text(item['detail']),
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
