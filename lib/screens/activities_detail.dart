import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ActivitiesDatail extends StatefulWidget {
  static const routeName = "/activities/detail";
  @override
  _ActivitiesDatailState createState() => _ActivitiesDatailState();
}

class _ActivitiesDatailState extends State<ActivitiesDatail> {
  @override
  Widget build(BuildContext context) {
    final ActivitiesDatailParams params =
        ModalRoute.of(context).settings.arguments as ActivitiesDatailParams;
    return Scaffold(
      appBar: AppBar(
        title: Text(params.title),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("Activities")
            .doc(params.id)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Column(
                children: <Widget>[
                  CircularProgressIndicator(),
                  Text("Loading......................"),
                ],
              ),
            );
          }
          if (snapshot.hasData) {
            final item = snapshot.data;
            return Container(
              child: Column(
                children: [
                  Text(item['detail']),
                  TextFormField(initialValue: item['detail'])
                ],
              ),
            );
          }
          return Center(
            child: Column(
              children: <Widget>[
                Text("No Data..............."),
              ],
            ),
          );
        },
      ),
    );
  }
}

class ActivitiesDatailParams {
  final String id;
  final String title;

  ActivitiesDatailParams(this.id, this.title);
}
