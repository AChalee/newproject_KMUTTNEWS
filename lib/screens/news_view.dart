import 'package:New_Project_KMUTTNEWS/tabview/latestNews_tab_view.dart';
import 'package:New_Project_KMUTTNEWS/tabview/post_news_tab.dart';
import 'package:New_Project_KMUTTNEWS/tabview/trend_news_header.dart';

import 'package:firebase_auth/firebase_auth.dart';
//import 'package:New_Project_KMUTTNEWS/tabview/post_tab.dart';
//import 'package:New_Project_KMUTTNEWS/tabview/trendingAct_tab_view.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import 'login_view.dart';

//import '../constants.dart';

class News extends StatefulWidget {
  static const routeName = '/news';
  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "KMUTT NEWS",
          style: TextStyle(
              fontSize: 24,
              fontFamily: 'Prompt',
              color: Colors.white,
              fontStyle: FontStyle.italic),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.notifications,
                color: Colors.white,
              ),
              onPressed: null),
          IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: null)
        ],
      ),
      //-----------------------------------------------------Tabbar View-------------------------------------------------------------
      body: Column(
        children: <Widget>[
          TrendNewsHeader(),
          SizedBox(
            height: 20,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 19.0),
              child: Text(
                "ข่าวสารล่าสุด",
                style: kNonActiveTabStyle,
              ),
            ),
          ),

          Divider(
            color: Colors.grey[500],
            indent: 15,
          ),
          SizedBox(
            height: 5,
          ),
          // Text(
          //   "ข่าวสารล่าสุด",
          //   style: kNonActiveTabStyle,
          // ),
          Expanded(
            child: LatestNewsTabView(),
          ),
        ],
      ),
      // --------------------------------------------add text------------------------------------------------------
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (FirebaseAuth.instance.currentUser != null) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddNews(),
              ),
            );
          } else {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  content: Text('กรุณาเข้าสู่ระบบ'),
                  actions: [
                    FlatButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Login(),
                            ),
                          );
                        },
                        child: Text('Login'))
                  ],
                );
              },
            );
          }
        },
        child: Icon(Icons.border_color),
        backgroundColor: Colors.orange,
      ),
    );
  }
}
