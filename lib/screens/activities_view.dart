import 'package:New_Project_KMUTTNEWS/constants.dart';
import 'package:New_Project_KMUTTNEWS/tabview/latestAct_tab_view.dart';
import 'package:New_Project_KMUTTNEWS/tabview/post_tab.dart';
//import 'package:New_Project_KMUTTNEWS/tabview/trendingAct_tab_view.dart';
import 'package:flutter/material.dart';
//import 'package:kmutt_news/views/addData.dart';

//import 'package:kmutt_news/views/latestAct_tab_view.dart';
//import 'package:kmutt_news/views/trendingAct_tab_view.dart';

class Activities extends StatefulWidget {
  static const routeName = '/activities';
  @override
  _ActivitiesState createState() => _ActivitiesState();
}

class _ActivitiesState extends State<Activities> {
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
            icon: Icon(
              Icons.notifications,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
          IconButton(
            tooltip: 'Search',
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
        ],
      ),
      // --------------------------------Tabbar View--------------------------------
      body: Column(
        children: <Widget>[
          //TrendActHeader(),
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
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddData()));
        },
        child: Icon(Icons.border_color),
        backgroundColor: Colors.orange,
      ),
    );
  }
}
