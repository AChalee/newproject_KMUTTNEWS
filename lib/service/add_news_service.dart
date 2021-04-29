import 'package:New_Project_KMUTTNEWS/component/show_notification.dart';
import 'package:New_Project_KMUTTNEWS/service/logger_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Future<void> addNewsItem(
    BuildContext context, Map<String, dynamic> data, String documentName) {
  return Firestore.instance
      .collection("News")
      .document()
      .set(data)
      .then((returnData) {
    showMessageBox(context, "Success", "Added Data to Firebase",
        actions: [dismissButton(context)]);
    logger.i("setData Success");
  }).catchError((e) {
    logger.e(e);
  });
}
