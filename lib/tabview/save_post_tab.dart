import 'package:New_Project_KMUTTNEWS/screens/news_detail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../constants.dart';

class SavePostTab extends StatefulWidget {
  // const SavePostTab({Key? key}) : super(key: key);

  @override
  _SavePostTabState createState() => _SavePostTabState();
}

class _SavePostTabState extends State<SavePostTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bookmark"),
      ),
      body: Container(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("News")
          .where("bookmark",arrayContains: FirebaseAuth.instance.currentUser.uid)

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
            if (snapshot.hasData && snapshot.data.documents.length > 0) {
              return ListView.builder(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot item = snapshot.data.documents[index];

                  return InkWell(
                    onTap: () async {

                      await Navigator.pushNamed(
                        context,
                        NewsDetail.routeName,
                        arguments: NewsDetailParams(
                          item.id,
                          item['title'],
                        ),
                        // title: Text(item['title']),
                        // subtitle: Text(item['detail']),
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      height: 135.0,
                      margin:
                      EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 8.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            border: Border.all(color: kGrey3, width: 1.0)),
                        child: Row(
                          children: [
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
                                padding: EdgeInsets.symmetric(vertical: 5.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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

                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
            if (snapshot.hasError) {

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
      ),
      //),
    );
  }
}