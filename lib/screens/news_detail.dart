import 'package:New_Project_KMUTTNEWS/constants.dart';
import 'package:New_Project_KMUTTNEWS/service/logger_service.dart';
import 'package:New_Project_KMUTTNEWS/widget/circle_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

class NewsDetail extends StatefulWidget {
  static final routeName = "/news/detail";
  @override
  _NewsDetailState createState() => _NewsDetailState();
}

class _NewsDetailState extends State<NewsDetail> {
  // final _saved = Set<WordPair>();

  @override
  Widget build(BuildContext context) {
    final NewsDetailParams params =
    ModalRoute.of(context).settings.arguments as NewsDetailParams;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(65.0),
        child: Center(
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.fromLTRB(18.0, 15.0, 18.0, 0),
              child: Row(
                children: [
                  CircleButton(
                    icon: Icons.arrow_back_ios,
                    onTap: () => Navigator.pop(context),
                  ),
                  Spacer(),
                   CircleButton(
                  //   icon: Icons.favorite_border,
                  //   onTap: () async{
                  //     await FirebaseFirestore.instance
                  //         .collection('News')
                  //         .doc(params.id)
                  //         .update(
                  //       {'likes': params['likes']+1},
                  //     );
                  //   },
                  ),
                  CircleButton(
                    icon: Icons.share,
                    onTap: () {
                      Share.share(

                          params.picture,
                          subject: params.title
                      );
                    },
                  ),
                  CircleButton(

                    icon: Icons.bookmark_border,

                    onTap: () async {

                      if (FirebaseAuth.instance.currentUser != null) {
                        print("มีอะไรออกมาไหม ?");
                        print(params.id);
                        await FirebaseFirestore.instance
                            .collection('News')
                            .doc(params.id)
                            .update({
                          'bookmark': [FirebaseAuth.instance.currentUser.uid],
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
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
              padding: EdgeInsets.symmetric(horizontal: 18.0),
              child: ListView(
                children: [
                  SizedBox(
                    height: 12.0,
                  ),
                  Container(
                    height: 220.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      image: DecorationImage(
                          image: NetworkImage(item['picture']),
                          fit: BoxFit.fill),
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Text(
                    item['title'],
                    style: kTitleCard.copyWith(fontSize: 20.0),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Text(
                    item['detail'],
                    style: descriptionStyle,
                  )
                ],
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
  final String picture;


  NewsDetailParams(this.id, this.title,this.picture);
}