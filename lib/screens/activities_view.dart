import 'package:New_Project_KMUTTNEWS/tabview/latestAct_tab_view.dart';
import 'package:New_Project_KMUTTNEWS/tabview/post_tab.dart';
import 'package:New_Project_KMUTTNEWS/tabview/trendingAct_tab_view.dart';
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
      body: DefaultTabController(
        length: 2,
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                constraints: BoxConstraints.expand(height: 50),
                child: TabBar(
                  indicatorWeight: 3,
                  indicatorColor: Colors.orange,
                  labelColor: Colors.orange,
                  unselectedLabelColor: Colors.grey,
                  tabs: [
                    Tab(
                        child: Text('กิจกรรมล่าสุด',
                            style:
                                TextStyle(fontSize: 17, fontFamily: 'Prompt'))),
                    Tab(
                        child: Text(
                      'กิจกรรมเป็นที่นิยม',
                      style: TextStyle(fontSize: 17, fontFamily: 'Prompt'),
                    )),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  child: TabBarView(children: [
                    LatestActTabView(),
                    TrendingActTabView(),
                  ]),
                ),
              )
            ],
          ),
        ),
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
