//import 'package:New_Project_KMUTTNEWS/tabview/read.dart';
import 'package:New_Project_KMUTTNEWS/screens/news_detail.dart';
import 'package:New_Project_KMUTTNEWS/service/logger_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class LatestNewsTabView extends StatefulWidget {
  LatestNewsTabView({Key key, this.newsTitle, this.newsContent})
      : super(key: key);
  final String newsTitle;
  final String newsContent;

  @override
  _LatestNewsTabViewState createState() => _LatestNewsTabViewState();
}

class _LatestNewsTabViewState extends State<LatestNewsTabView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
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
                return ListTile(
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
    );
  }
}
