import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Read extends StatefulWidget {
  final String newsTitle;
  final String newsContent;
  Read({Key key, @required this.newsTitle, @required this.newsContent})
      : super(key: key);

  @override
  _ReadState createState() => _ReadState();
}

class _ReadState extends State<Read> {
  String newsContent = "Please wait......";

  @override
  void initState() {
    super.initState();
    Firestore.instance
        .collection("News")
        .document(widget.newsTitle)
        .get()
        .then((value) {
      setState(() {
        newsContent = value.data()["content"];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
