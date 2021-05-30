import 'package:New_Project_KMUTTNEWS/screens/activities_view.dart';
import 'package:New_Project_KMUTTNEWS/service/add_news_service.dart';
import 'package:New_Project_KMUTTNEWS/widget/circle_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class EditActivities extends StatefulWidget {
  static final routeName = "/activities/edit";
  @override
  _EditActivitiesState createState() => _EditActivitiesState();
}

class _EditActivitiesState extends State<EditActivities> {
  final _formkey = GlobalKey<FormState>();

  TextEditingController actTitleController;
  TextEditingController actDetailController;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final ActivitiesEditParams params =
          ModalRoute.of(context).settings.arguments as ActivitiesEditParams;
      actTitleController = TextEditingController(text: params.title);
      actDetailController = TextEditingController(text: params.detail);
    });
  }

  @override
  Widget build(BuildContext context) {
    final ActivitiesEditParams params =
        ModalRoute.of(context).settings.arguments as ActivitiesEditParams;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(65.0),
        child: Center(
          child: SafeArea(
              child: Padding(
            padding: EdgeInsets.fromLTRB(18.0, 15.0, 18.0, 0),
            child: Row(
              children: [
                CircleButton(
                  icon: Icons.arrow_back_ios,
                  onTap: () => Navigator.pop(context),
                ),
              ],
            ),
          )),
        ),
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
                  Text("Loading........."),
                ],
              ),
            );
          }
          if (snapshot.hasData) {
            final item = snapshot.data;
            return Form(
              key: _formkey,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 18.0),
                child: ListView(
                  children: [
                    SizedBox(
                      height: 12.0,
                    ),
                    Container(
                      height: 220.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        image: DecorationImage(
                            image: NetworkImage(item['picture']),
                            fit: BoxFit.fill),
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Text(
                      "หัวข้อ",
                      style: kTitleCard.copyWith(fontSize: 20.0),
                    ),
                    TextFormField(
                      controller: actTitleController,
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Text(
                      "รายละเอียด",
                      style: descriptionStyle,
                    ),
                    TextFormField(
                      controller: actDetailController,
                    ),
                    MaterialButton(
                      onPressed: () async {
                        await FirebaseFirestore.instance
                            .collection("Activities")
                            .doc(item.id)
                            .update(
                          {
                            'title': actTitleController.text,
                            'detail': actDetailController.text
                          },
                        );
                      },
                      child: Text('บันทึก'),
                      color: kGrey3,
                    ),
                  ],
                ),
              ),
            );
          }
          if (snapshot.hasError) {
            logger.e("Fetch news error : ${snapshot.error.toString()}");
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
    );
  }
}

class ActivitiesEditParams {
  final String id;
  final String title;
  final String detail;

  ActivitiesEditParams(this.id, this.detail, this.title);
}
