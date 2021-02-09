import 'package:cloud_firestore/cloud_firestore.dart';

//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class LatestNewsTabView extends StatefulWidget {
  LatestNewsTabView({Key key, this.newsTitle, this.newsContent})
      : super(key: key);
  final String newsTitle;
  final String newsContent;

  @override
  _LatestNewsTabViewState createState() => _LatestNewsTabViewState();
}

class _LatestNewsTabViewState extends State<LatestNewsTabView> {
  @override
  void initState() {
    super.initState();
    Firestore.instance
        .collection("News")
        .document(widget.newsTitle)
        .get()
        .then((value) {
      setState(() {});
    });
    //Firebase.initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: Firestore.instance.collection("News").snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: Column(
                  children: <Widget>[
                    CircularProgressIndicator(),
                    Text("Loading........."),
                  ],
                ),
              );
            } else {
              return ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: Container(
                          child: InkWell(
                            onTap: () {},
                            child: Column(
                              children: [
                                ListTile(
                                  title: Text(snapshot
                                      .data.documents[index].documentID),
                                  subtitle: Text(
                                      snapshot.data.documents[index]["title"]),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  });
            }
          }),
    );
  }
}
