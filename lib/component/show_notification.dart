import 'package:New_Project_KMUTTNEWS/service/logger_service.dart';
import 'package:flutter/material.dart';

void showNotificaation(BuildContext context,
    {AlertDialog alertContent, Stack stackContent}) async {
  try {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return alertContent == null ? stackContent : alertContent;
        });
  } catch (e) {
    logger.e(e.toString());
    return null;
  }
}

void showMessageBox(BuildContext context, String titleText, String contentText,
    {List<Widget> actions}) async {
  try {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: Text(titleText),
            content: Text(contentText),
            actions: actions,
          );
        });
  } catch (e) {
    logger.e(e.toString());
    return null;
  }
}

RaisedButton dismissButton(BuildContext context) {
  return RaisedButton(
    onPressed: () {
      Navigator.pop(context);
    },
    child: Text("Dismis"),
  );
}
