import 'dart:io';

import 'package:New_Project_KMUTTNEWS/component/show_notification.dart';
import 'package:New_Project_KMUTTNEWS/constants.dart';
import 'package:New_Project_KMUTTNEWS/service/add_activities_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';

class AddActivities extends StatefulWidget {
  @override
  _AddActivitiesState createState() => _AddActivitiesState();
}

class _AddActivitiesState extends State<AddActivities> {
  final acttitle = TextEditingController();
  final actdetail = TextEditingController();

  Logger logger = Logger();
  String imageUrl, title;
  final _storage = FirebaseStorage.instance;
  final database = Firestore.instance;
  final _picker = ImagePicker();
  PickedFile image;
  File file;

  @override
  Widget build(BuildContext context) {
    DateTime datenow = DateTime.now();
    Timestamp dateTimeStamp = Timestamp.fromDate(datenow);

    searchData(String title) async {
      List<String> splitList = title.split(' ');
      List<String> indexList = [];
      for (int i = 0; i < splitList.length; i++,) {
        for (int j = 0; j < splitList[i].length; j++) {
          indexList.add(splitList[i].substring(0, j + 1).toLowerCase());
        }
      }
      database.collection('Activities').add({
        "picture": imageUrl,
        "create_at": dateTimeStamp,
        "title": acttitle.text,
        "detail": actdetail.text,
        "view_count": 0,
        "user_id": FirebaseAuth.instance.currentUser.uid,
        "searchKeywords": indexList,
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'กิจกรรมวันนี้',
          style: TextStyle(
              fontSize: 24,
              fontFamily: 'Prompt',
              color: Colors.white,
              fontStyle: FontStyle.italic
          ),
        ),
        backgroundColor: Colors.orange[700],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              file != null
                  ? Container(
                      child: Image.file(file),
                      // height: 200,
                    )
                  : Placeholder(
                      fallbackHeight: 200.0,
                      fallbackWidth: double.infinity,
                    ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Card(
                    shadowColor: kGrey3,
                    child: IconButton(
                        icon: Icon(Icons.add_a_photo),
                        onPressed: () {
                          //getImage();
                          uploadImage();
                        }),
                  ),
                  Card(
                    shadowColor: kGrey3,
                    child: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          //getImage();
                          setState(() {
                            file = null;
                          });
                        }),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      style: descriptionStyle,
                      decoration: InputDecoration(
                        labelText: "หัวข้อข่าว",
                        labelStyle: descriptionStyle
                      ),
                      controller: acttitle,
                    ),
                    Padding(padding: const EdgeInsets.all(10)),
                    TextFormField(
                      style: descriptionStyle,
                      decoration: InputDecoration(
                        labelText: "รายละเอียด",
                        labelStyle: descriptionStyle
                      ),
                      controller: actdetail,
                    ),
                    SizedBox(height: 20.0),
                    RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                        color: Colors.orange[500],
                        padding:
                            EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                        child: Text(
                          "โพสต์",
                          style: descriptionStyle                        ),
                        onPressed: () {
                          var snapshot = _storage
                              .ref()
                              .child('ActPhoto/imageName')
                              .putFile(file)
                              .onComplete;
                          if (acttitle.text == "" || actdetail.text == '') {
                            showMessageBox(context, "error",
                                "กรุณากรอกรายละเอียดก่อนโพสต์",
                                actions: [dismissButton(context)]);
                            logger.e("newstitle or newsdetail can not be null");
                          } else {
                            searchData(acttitle.text);
                          }
                          Navigator.pop(context);
                        })
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  uploadImage() async {
    await Permission.photos.request();

    var permissionStatus = await Permission.photos.status;

    if (permissionStatus.isGranted) {
      //Select Image

      image = await _picker.getImage(source: ImageSource.gallery);
      // var file = File(image.path);
      setState(() {
        file = File(image.path);
      });

      // if (image != null) {
      //Upload to Firebase
      var snapshot = await _storage
          .ref()
          .child('ActPhoto/${DateTime.now()}')
          .putFile(file)
          .onComplete;

      var dowloadUrl = await snapshot.ref.getDownloadURL();

      setState(() {
        imageUrl = dowloadUrl;
      });
    }
  }
}
