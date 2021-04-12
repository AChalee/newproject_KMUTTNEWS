import 'package:New_Project_KMUTTNEWS/service/logger_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NewsDetail extends StatefulWidget {
  static final routeName = "/news/detail";
  @override
  _NewsDetailState createState() => _NewsDetailState();
}

class _NewsDetailState extends State<NewsDetail> {
  @override
  Widget build(BuildContext context) {
    final NewsDetailParams params =
        ModalRoute.of(context).settings.arguments as NewsDetailParams;
    return Scaffold(
      appBar: AppBar(
        title: Text(params.title),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("News")
            .doc(params.id)
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
          if (snapshot.hasData) {
            final item = snapshot.data;
            return Container(
              child: Text(item['detail']),
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

class NewsDetailParams {
  final String id; //กดมาจากหน้า latestNews
  final String title;

  NewsDetailParams(this.id, this.title);
}
