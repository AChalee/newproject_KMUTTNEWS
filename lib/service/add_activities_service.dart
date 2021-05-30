import 'dart:math';

import 'package:New_Project_KMUTTNEWS/component/show_notification.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';

Logger logger = Logger();

Future<void> addActItem(
  BuildContext context,
  Map<String, dynamic> data,
) {
  return Firestore.instance
      .collection("Activities")
      .add(data)
      .then((returnData) {
    showMessageBox(context, "Success", "Added Data to Firebase",
        actions: [dismissButton(context)]);
    logger.i("setData Success");
  }).catchError(
    (e) {
      logger.e(e);
    },
  );
}
