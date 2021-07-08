import 'package:New_Project_KMUTTNEWS/screens/bookmark_view.dart';
import 'package:New_Project_KMUTTNEWS/screens/profile_user.dart';
import 'package:New_Project_KMUTTNEWS/tabview/save_post_tab.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

import 'package:New_Project_KMUTTNEWS/screens/login_view.dart';

import 'package:firebase_auth/firebase_auth.dart';

import '../constants.dart';

//import 'dart:io';

// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:kmutt_news/constants.dart';
//import 'package:kmutt_news/widgets/category_card.dart';
// import 'package:kmutt_news/constants.dart';
// import 'package:image/image.dart';

class AddMore extends StatefulWidget {
  // static const routeName = '/more';
  @override
  State<StatefulWidget> createState() {
    return _AddMoreState();
  }
}

class _AddMoreState extends State<AddMore> {
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(
            "MENU",
            style: TextStyle(
                fontSize: 24,
                fontFamily: 'Prompt',
                color: Colors.white,
                fontStyle: FontStyle.italic),
            // style: TextStyle(
            //   color: Colors.white,
            //   fontSize: 20,
            //   fontFamily: 'Itim',
            // ),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.lock_open,
                color: Colors.white,
              ),
              onPressed: () {
                auth.signOut().then((value) {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                    return Login();
                  }));
                });
              },
            ),
          ],
        ),
        //-----------------------------------------------------Tabbar View-------------------------------------------------------------
        body: Container(
          padding: EdgeInsets.all(30),
          child: GridView.count(
            crossAxisCount: 2,
            childAspectRatio: .85,
            crossAxisSpacing: 20,
            mainAxisSpacing: 40,
            children: <Widget>[
              Card(
                margin: EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Login(),
                      ),
                    );
                  },
                  splashColor: Colors.orange[500],
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Image.asset(
                          'assets/image/lock.png',
                          width: 60,
                          height: 60,
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Text(
                          "Login",
                          style: descriptionStyle,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Card(
                margin: EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Profile(),
                      ),
                    );
                  },
                  splashColor: Colors.orange[500],
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Image.asset(
                          'assets/image/like.png',
                          width: 60,
                          height: 60,
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Text("Profile", style: descriptionStyle),
                      ],
                    ),
                  ),
                ),
              ),
              Card(
                margin: EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookmarkView(),
                      ),
                    );
                  },
                  splashColor: Colors.orange[500],
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Image.asset(
                          'assets/image/save.png',
                          width: 60,
                          height: 60,
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Text("Save", style: descriptionStyle)
                      ],
                    ),
                  ),
                ),
              ),
              Card(
                margin: EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SavePostTab(),
                      ),
                    );
                  },
                  splashColor: Colors.orange[500],
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Image.asset(
                          'assets/image/settings.png',
                          width: 60,
                          height: 60,
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Text("Setting", style: descriptionStyle)
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
