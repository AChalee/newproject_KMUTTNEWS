import 'package:New_Project_KMUTTNEWS/constants.dart';
import 'package:New_Project_KMUTTNEWS/models/news.dart';
import 'package:New_Project_KMUTTNEWS/tabview/read_news_view.dart';
import 'package:New_Project_KMUTTNEWS/widget/primary_card.dart';
import 'package:New_Project_KMUTTNEWS/widget/secondary_card.dart';
import 'package:flutter/material.dart';
//import 'package:kmutt_news/constants.dart';
//import 'package:kmutt_news/models/news.dart';
//import 'package:kmutt_news/views/read_news_view.dart';
//import 'package:kmutt_news/widgets/primary_card.dart';
//import 'package:kmutt_news/widgets/secondary_card.dart';

class LatestActTabView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          Container(
            width: double.infinity,
            height: 300.0,
            padding: EdgeInsets.only(left: 18.0, top: 20),
            child: ListView.builder(
                itemCount: latestList.length,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  var news = latestList[index];

                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ReadNewsView(
                            news: news,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 12.0),
                      child: PrimaryCard(news: news),
                    ),
                  );
                }),
          ),
          SizedBox(
            height: 25.0,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 19.0),
              child: Text(
                "Base On Your Reading History",
                style: kNonActiveTabStyle,
              ),
            ),
          ),
          // --------------------------------- card ส่วนล่างแนวตั้ง----------------------------------------------
          ListView.builder(
            itemCount: recentList.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemBuilder: (context, index) {
              var recent = recentList[index];
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ReadNewsView(
                        news: recent,
                      ),
                    ),
                  );
                },
                child: Container(
                  width: double.infinity,
                  height: 135.0,
                  margin: EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
                  child: SecondaryCard(
                    news: recent,
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:kmutt_news/constants.dart';
// import 'package:kmutt_news/models/news.dart';
// //import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:kmutt_news/views/read_news_view.dart';

// class LatestActTabView extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     CollectionReference mypost =
//         FirebaseFirestore.instance.collection('PostNews');

// // FirebaseFirestore.instance
// //   .collection('PostNews')
// //   .where('age', isGreaterThan: 20)
// //   .get()
// //   .then();

//     return StreamBuilder<QuerySnapshot>(
//       stream: mypost.snapshots(),
//       builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//         if (snapshot.hasError) {
//           return Text('Something went wrong');
//         }

//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Text("Loading");
//         }

//         return new ListView(
//           children: snapshot.data.documents.map((DocumentSnapshot document) {
//             return new ListTile(
//               //leading: Image.network(document.data()['UrlImage']),
//               leading: Image.network(document.data()['UrlImage'],
//                   width: 128, fit: BoxFit.fitWidth),
//               title: new Text(document.data()['Topic']),
//               subtitle: new Text(document.data()['Detail']),
//               // onTap: () {
//               //   Navigator.push(
//               //     context,
//               //     MaterialPageRoute(
//               //       builder: (context) => ReadNewsView(),
//               //     ),
//               //   );
//               // },
//             );
//             // return InkWell(
//             //   onTap: () {
//             //     Navigator.push(
//             //       context,
//             //       MaterialPageRoute(
//             //         builder: (context) => ReadNewsView(),
//             //       ),
//             //     );
//             //   },
//             // );
//           }).toList(),
//         );
//       },
//     );
//   }
// }
