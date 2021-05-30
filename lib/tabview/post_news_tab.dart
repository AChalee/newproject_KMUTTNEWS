import 'dart:io';

import 'package:New_Project_KMUTTNEWS/component/show_notification.dart';
import 'package:New_Project_KMUTTNEWS/constants.dart';
//import 'package:New_Project_KMUTTNEWS/screens/news_detail.dart';
import 'package:New_Project_KMUTTNEWS/service/add_news_service.dart';
//import 'package:New_Project_KMUTTNEWS/service/logger_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
//import 'package:image_cropper/image_cropper.dart';
import 'package:permission_handler/permission_handler.dart';

class AddNews extends StatefulWidget {
  AddNews({Key key}) : super(key: key);

  @override
  _AddNewsState createState() => _AddNewsState();
}

class _AddNewsState extends State<AddNews> {
  final newstitle = TextEditingController();
  final newsdetail = TextEditingController();
  Logger logger = Logger();
  String imageUrl;
  final _storage = FirebaseStorage.instance;
  final _picker = ImagePicker();
  PickedFile image;
  File file;

  @override
  Widget build(BuildContext context) {
    DateTime dateNow = DateTime.now();
    Timestamp dateTimeStamp = Timestamp.fromDate(dateNow);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ข่าวสารวันนี้',
          style: TextStyle(color: Colors.white),
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
                      height: 200,
                      width: 500,
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
                      },
                    ),
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
                      controller: newstitle,
                    ),
                    Padding(padding: const EdgeInsets.all(10)),
                    TextFormField(
                      decoration: InputDecoration(labelText: "รายละเอียด"),
                      controller: newsdetail,
                    ),
                    RaisedButton(
                        child: Text(
                          "โพสต์",
                          style: kTitleCard,
                        ),
                        onPressed: () {
                          if (newstitle.text == "" || newsdetail.text == '') {
                            showMessageBox(context, "error",
                                "กรุณากรอกรายละเอียดก่อนโพสต์",
                                actions: [dismissButton(context)]);
                            logger.e("newstitle or newsdetail can not be null");
                          } else {
                            addNewsItem(
                              context,
                              {
                                "picture": imageUrl,
                                "create_at": dateTimeStamp,
                                "title": newstitle.text,
                                "detail": newsdetail.text,
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

      //if (image != null) {
      //Upload to Firebase
      var snapshot = await _storage
          .ref()
          .child('NewsPhoto/imageName')
          .putFile(file)
          .onComplete;

      var dowloadUrl = await snapshot.ref.getDownloadURL();

      setState(() {
        imageUrl = dowloadUrl;
      });
    }
  }
}
