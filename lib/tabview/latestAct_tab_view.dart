import 'package:New_Project_KMUTTNEWS/screens/activities_detail.dart';
import 'package:New_Project_KMUTTNEWS/screens/login_view.dart';
//import 'package:New_Project_KMUTTNEWS/screens/activities_view.dart';
import 'package:New_Project_KMUTTNEWS/service/logger_service.dart';
import 'package:New_Project_KMUTTNEWS/tabview/edit_activities.dart';
import 'package:New_Project_KMUTTNEWS/tabview/edit_news.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class LatestActTabView extends StatefulWidget {
  @override
  _LatestActTabViewState createState() => _LatestActTabViewState();
}

class _LatestActTabViewState extends State<LatestActTabView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("Activities")
                .orderBy('create_at', descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Column(
                    children: <Widget>[
                      CircularProgressIndicator(),
                      Text("Loading.................."),
                    ],
                  ),
                );
              }
              if (snapshot.hasData && snapshot.data.documents.length > 0) {
                return ListView.builder(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index) {
                      final DocumentSnapshot item =
                          snapshot.data.documents[index];

                      return InkWell(
                        onTap: () async {
                          await FirebaseFirestore.instance
                              .collection("Activities")
                              .doc(item.id)
                              .update(
                            {'view_count': item['view_count'] + 1},
                          );
                          await Navigator.pushNamed(
                            context,
                            ActivitiesDatail.routeName,
                            arguments: ActivitiesDatailParams(
                              item.id,
                              item['title'],
                                item['picture']
                            ),
                          );
                        },
                        child: Container(
                          width: double.infinity,
                          height: 135.0,
                          margin: EdgeInsets.symmetric(
                              horizontal: 18.0, vertical: 8.0),
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 8.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                border: Border.all(color: kGrey3, width: 1.0)),
                            child: Row(
                              children: [
                                // Text(item['title']),
                                // Text(item['detail']),
                                //Image.network(item['picture']),
                                Container(
                                  width: 90.0,
                                  height: 135.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.0),
                                    image: DecorationImage(
                                      image: NetworkImage(item['picture']),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 12.0,
                                ),
                                Expanded(
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 5.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item['title'],
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: kTitleCard,
                                        ),
                                        SizedBox(
                                          height: 4.0,
                                        ),
                                        Text(
                                          item['detail'],
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: kDetailContent,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.more_horiz),
                                  onPressed: () {
                                    final auth = FirebaseAuth.instance;

                                    try {
                                      print('เช็ค loginใช้ไม่ได้โว้ยยย  : ');
                                      print(auth.currentUser.uid);

                                      print("item['user_id'] : ");
                                      print(item['user_id']);

                                      print("item['detail'] : ");
                                      print(item['detail']);

                                      // item.forEach((element) => print(element));

                                    } on Exception catch (exception) {
                                      // only executed if error is of type Exception
                                    } catch (error) {
                                      // executed for errors of all types other than Exception
                                    }

                                    if (auth.currentUser != null) {
                                      if (auth.currentUser.uid ==
                                          item['user_id']) {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              content: Text('ตั้งค่า'),
                                              actions: [
                                                FlatButton(
                                                  onPressed: () async {
                                                    await FirebaseFirestore
                                                        .instance
                                                        .collection(
                                                            "Activities")
                                                        .doc(item.id)
                                                        .delete();

                                                    Navigator.pop(context);
                                                  },
                                                  child: Text('ลบออก'),
                                                ),
                                                FlatButton(
                                                  onPressed: () {
                                                    Navigator.pushNamed(
                                                      context,
                                                      EditActivities.routeName,
                                                      arguments:
                                                          ActivitiesEditParams(
                                                        item.id,
                                                        item['detail'],
                                                        item['title'],
                                                      ),
                                                    );
                                                  },
                                                  child: Text('แก้ไข'),
                                                ),
                                                FlatButton(
                                                  onPressed: () {},
                                                  child: Text('ยกเลิก'),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      }
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
                                                      builder: (context) =>
                                                          Login(),
                                                    ),
                                                  );
                                                },
                                                child: Text('Login'),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    });
              }
              if (snapshot.hasError) {
                logger
                    .e("Fetch activities error : ${snapshot.error.toString()}");
                return Center(
                  child: Column(
                    children: <Widget>[
                      Text("Error Something.................."),
                    ],
                  ),
                );
              }
              return Center(
                child: Column(
                  children: <Widget>[Text("No Data........................")],
                ),
              );
            }),
      ),
    );
  }
}
