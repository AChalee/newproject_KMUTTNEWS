import 'dart:io';

import 'package:New_Project_KMUTTNEWS/component/show_notification.dart';
import 'package:New_Project_KMUTTNEWS/constants.dart';
//import 'package:New_Project_KMUTTNEWS/screens/news_detail.dart';
import 'package:New_Project_KMUTTNEWS/service/add_news_service.dart';
import 'package:New_Project_KMUTTNEWS/service/logger_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:image_cropper/image_cropper.dart';
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
  // final picker = ImagePicker();
  // File _image;
  String imageUrl;

  // Future getImage() async {
  //   final pickedFile = await picker.getImage(source: ImageSource.gallery);
  //   setState(() {
  //     if (pickedFile != null) {
  //       _image = pickedFile.path as File;
  //     } else {
  //       print('No image selected.');
  //     }
  //   });
  // }

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
              Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    Card(
                      shadowColor: kGrey3,
                      child: IconButton(
                          icon: Icon(Icons.add_a_photo),
                          onPressed: () {
                            //getImage();
                            uploadImage();
                          }),
                    ),
                    // InkWell(

                    //   child: IconButton(
                    //       icon: Icon(Icons.add_a_photo),
                    //       onPressed: () {
                    //         getImage();
                    //       }),
                    // ),
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
                    // Container(
                    //   height: 100,
                    //   width: 100,
                    //   color: Colors.black,
                    //   child: RaisedButton(
                    //     onPressed: () {
                    //       getImage();
                    //     },
                    //   ),
                    // ),
                    // Padding(padding: const EdgeInsets.all(10)),
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
    final _storage = FirebaseStorage.instance;
    final _picker = ImagePicker();
    PickedFile image;
    //Check Permission
    await Permission.photos.request();

    var permissionStatus = await Permission.photos.status;

    if (permissionStatus.isGranted) {
      //Select Image

      image = await _picker.getImage(source: ImageSource.gallery);
      var file = File(image.path);

      if (image != null) {
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
      } else {
        print('No Path Received');
      }
    } else {
      print('Grant Permissions and try again');
    }
  }
}
