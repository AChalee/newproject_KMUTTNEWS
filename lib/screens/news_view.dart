import 'package:New_Project_KMUTTNEWS/tabview/latestNews_tab_view.dart';
import 'package:New_Project_KMUTTNEWS/tabview/post_news_tab.dart';
//import 'package:New_Project_KMUTTNEWS/tabview/post_tab.dart';
import 'package:New_Project_KMUTTNEWS/tabview/trendingAct_tab_view.dart';
import 'package:flutter/material.dart';

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
                        child: Text(
                          "ข่าวสารล่าสุด",
                          style: TextStyle(fontSize: 17, fontFamily: 'Prompt'),
                        ),
                      ),
                      Tab(
                        child: Text(
                          'ข่าวสารเป็นที่นิยม',
                          style: TextStyle(fontSize: 17, fontFamily: 'Prompt'),
                        ),
                      )
                    ]),
              ),
              Expanded(
                child: Container(
                  child: TabBarView(children: [
                    LatestNewsTabView(),
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
              context, MaterialPageRoute(builder: (context) => AddNews()));
        },
        child: Icon(Icons.border_color),
        backgroundColor: Colors.orange,
      ),
    );
  }
}
