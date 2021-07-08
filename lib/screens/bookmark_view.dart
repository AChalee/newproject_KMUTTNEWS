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
        begin: Alignment.topCenter,
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

            ),
          )

        ],
      ),)
    ], 
  ),
),
    );
  }
}
