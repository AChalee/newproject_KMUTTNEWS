import 'package:New_Project_KMUTTNEWS/component/show_notification.dart';
import 'package:New_Project_KMUTTNEWS/service/logger_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

Logger logger = Logger();

Future<void> addNewsItem(
  BuildContext context,
  Map<String, dynamic> data,
) {
  return Firestore.instance.collection("News").add(data).then((returnData) {
    showMessageBox(context, "Success", "Added Data to Firebase",
        actions: [dismissButton(context)]);
    logger.i("setData Success");
  }).catchError((e) {
    logger.e(e);
  });
}

// import 'package:cloud_firestore/cloud_firestore.dart';

// import 'package:flutter/material.dart';

// class AddNewsItem extends StatefulWidget {
//   final String title;
//   final String detail;
//   AddNewsItem(this.title, this.detail);

//   @override
//   _AddNewsItemState createState() => _AddNewsItemState();
// }

// class _AddNewsItemState extends State<AddNewsItem> {
//   @override
//   Widget build(BuildContext context) {
//     CollectionReference item = FirebaseFirestore.instance.collection("News");

//     Future<void>addNewsItem(){
//       return item.add({
//         'newsTitle' : title,
//         'newsdetail' :  ,
//       })
//       .then((value) => null)
//     }
//     return Container();
//   }
// }
