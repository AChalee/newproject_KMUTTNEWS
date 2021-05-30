import 'dart:io';

import 'package:New_Project_KMUTTNEWS/component/show_notification.dart';
import 'package:New_Project_KMUTTNEWS/constants.dart';
import 'package:New_Project_KMUTTNEWS/service/add_activities_service.dart';
import 'package:New_Project_KMUTTNEWS/service/add_news_service.dart';
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
  String imageUrl;
  final _storage = FirebaseStorage.instance;
  var _picker = ImagePicker();
  PickedFile image;
  File file;

  @override
  Widget build(BuildContext context) {
    DateTime datenow = DateTime.now();
    Timestamp dateTimeStamp = Timestamp.fromDate(datenow);
    return Scaffold(
      appBar: AppBar(
        title: Text('กิจกรรมวันนี้'),
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
              // : Container(
              //     child: Text('T'),
              //   ),
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
                      decoration: InputDecoration(
                        labelText: "หัวข้อข่าว",
                      ),
                      controller: acttitle,
                    ),
                    Padding(padding: const EdgeInsets.all(10)),
                    TextFormField(
                      decoration: InputDecoration(labelText: "รายละเอียด"),
                      controller: actdetail,
                    ),
                    RaisedButton(
                        child: Text(
                          "โพสต์",
                          style: kTitleCard,
                        ),
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
                            addActItem(
                              context,
                              {
                                "picture": imageUrl,
                                "create_at": dateTimeStamp,
                                "title": acttitle.text,
                                "detail": actdetail.text,
                                "view_count": 0,
                                "user_id":
                                    FirebaseAuth.instance.currentUser.uid,
                              },
                            );
                          }
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
          .child('ActPhoto/imageName')
          .putFile(file)
          .onComplete;

      var dowloadUrl = await snapshot.ref.getDownloadURL();

      setState(() {
        imageUrl = dowloadUrl;
      });
      // } else {
      //   print('No Path Received');
      // }
      // } else {
      //   print('Grant Permissions and try again');
    }
  }
}
