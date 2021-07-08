import 'package:New_Project_KMUTTNEWS/constants.dart';
import 'package:New_Project_KMUTTNEWS/tabview/bookmark_act_tab.dart';
import 'package:New_Project_KMUTTNEWS/tabview/bookmark_news_tab.dart';
import 'package:New_Project_KMUTTNEWS/tabview/save_post_tab.dart';
import 'package:flutter/material.dart';

class BookmarkView extends StatefulWidget {
  @override
  _BookmarkViewState createState() => _BookmarkViewState();
}

class _BookmarkViewState extends State<BookmarkView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
body:Container(
  padding: EdgeInsets.only(top: 10),
  width: double.infinity,
  decoration: BoxDecoration(
    gradient: LinearGradient(
        begin: Alignment.centerLeft,
    colors: [
      Colors.orange[900],
      Colors.orange[800],
      Colors.orange[400],
    ]),
  ),
  child: Column(
   crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      SizedBox(height: 10,),
      Padding(
          padding: const EdgeInsets.all(26),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('BOOKMARK',
            style: TextStyle(
                fontSize: 24,
                fontFamily: 'Prompt',
                color: Colors.white,
                fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold

            ),
          ),

        ],
      ),
      ),
      SizedBox(height: 1,),
      Expanded(
          child:Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
            ),
            child: DefaultTabController(
                 length: 2,
                 child: Container(
                   child: Column(
                     children: <Widget>[
                       SizedBox(
                         height: 15,
                       ),
                       Container(
                         constraints: BoxConstraints.expand(height: 50),
                         child: TabBar(
                             indicatorWeight: 3,
                             indicatorColor: Colors.orange,
                             unselectedLabelColor: Colors.grey,
                             labelColor: Colors.orange,

                             tabs: [
                               Tab(
                                   child: Text('ข่าวสาร ',
                                       style: kTitleCard
                           ),
                       ),
                               Tab(
                                   child: Text('กิจกรรม',
                                       style: kTitleCard),
            ),
                             ]),

                       ),
                       Expanded(
                           child: Container(
                             child: TabBarView(
                                 children: <Widget>[

                                   BookmarkNewsTab(),
                                   BookmarkActTab(),
                                 ]),
                           ),)
                     ],
                   ),
                 ),),
          ) ),
    ], 
  ),
),
    );
  }
}
