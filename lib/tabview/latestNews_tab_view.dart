//import 'dart:html';

//import 'package:New_Project_KMUTTNEWS/tabview/read_news_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class LatestNewsTabView extends StatefulWidget {
  LatestNewsTabView({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _LatestNewsTabViewState createState() => _LatestNewsTabViewState();
}

class _LatestNewsTabViewState extends State<LatestNewsTabView> {
  @override
  void initState() {
    super.initState();
    // Firebase.initializeApp().whenComplete(() {
    //   print("object");
    //   setState(() {});
    // });
  }

  @override
  Widget build(BuildContext context) {
    // CollectionReference news = FirebaseFirestore.instance.collection("")
    return Scaffold(
//         body: StreamBuilder(
//             stream: Firestore.instance.collection("News").snapshots(),
//             builder: (context, snapshot) {
//               if (!snapshot.hasData) {
//                 return Center(
//                   child: Column(
//                     children: <Widget>[
//                       CircularProgressIndicator(),
//                       Text("Loading..........."),
//                     ],
//                   ),
//                 );
//               } else {
//                 return ListView.builder(
//                   itemCount: snapshot.data.documents.length,
//                   itemBuilder: (context, index) {
//                     return Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Card(
//                         child: Container(
//                           child: InkWell(
//                             onTap: () {
//                               Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) => ReadNewsView(
//                                             newsTitle: snapshot.data
//                                                 .documents[index].documentID,
//                                             newsContent: snapshot.data
//                                                 .documents[index].data["title"],
//                                           )));
//                             },
//                             child: Column(
//                               children: <Widget>[
//                                 ListTile(
//                                   title: Text(snapshot
//                                       .data.documents[index].documentID),
//                                   subtitle: Text(snapshot
//                                       .data.documents[index].data["title"]),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               }
//             }));
//   }
// }
      body: FutureBuilder(
        future: getData(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Column(
              children: [
                Container(
                  height: 27,
                  child: Text(
                    "Name : ${snapshot.data.data()['title']}",
                    overflow: TextOverflow.fade,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            );
          } else if (snapshot.connectionState == ConnectionState.none) {
            return Text("No Data");
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }

  Future<DocumentSnapshot> getData() async {
    await Firebase.initializeApp();
    return await FirebaseFirestore.instance.collection("News").doc("IT").get();
  }
}
