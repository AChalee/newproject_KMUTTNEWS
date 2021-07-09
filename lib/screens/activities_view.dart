import 'package:New_Project_KMUTTNEWS/constants.dart';
import 'package:New_Project_KMUTTNEWS/tabview/latestAct_tab_view.dart';
//import 'package:New_Project_KMUTTNEWS/tabview/login_tab_view.dart';
import 'package:New_Project_KMUTTNEWS/tabview/post_activity_tab.dart';
import 'package:New_Project_KMUTTNEWS/tabview/search_act_tab.dart';

import 'package:New_Project_KMUTTNEWS/tabview/trend_activities_header.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'login_view.dart';

class Activities extends StatefulWidget {
  static const routeName = '/activities';
  @override
  _ActivitiesState createState() => _ActivitiesState();
}

class _ActivitiesState extends State<Activities> {
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text(
          'KMUTT NEWS',
          style: TextStyle(
              fontSize: 24,
              fontFamily: 'Prompt',
              color: Colors.white,
              fontStyle: FontStyle.italic),
        ),
        actions: <Widget>[

          IconButton(
            tooltip: 'Search',
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                context, MaterialPageRoute(
                  builder: (context)=>SearchActTab()),);
            },
          ),
        ],
      ),
      // --------------------------------Tabbar View--------------------------------
      body: Column(
        children: <Widget>[
          TrendActivitiesHeader(),
          SizedBox(
            height: 20,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 19.0),
              child: Text(
                "กิจกรรมล่าสุด",
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
          Expanded(
            child: LatestActTabView(),
          )
        ],
      ),
      // --------------------------------------------add text------------------------------------------------------
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (auth.currentUser != null) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddActivities(),
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
