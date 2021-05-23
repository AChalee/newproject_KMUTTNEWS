import 'dart:io';

import 'package:New_Project_KMUTTNEWS/constants.dart';
import 'package:New_Project_KMUTTNEWS/service/add_news_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class AddActivities extends StatefulWidget {
  @override
  _AddActivitiesState createState() => _AddActivitiesState();
}

class _AddActivitiesState extends State<AddActivities> {
  String imageUrl;
  final _storage = FirebaseStorage.instance;
  var _picker = ImagePicker();
  PickedFile image;
  File file;

  @override
  Widget build(BuildContext context) {
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
                      height: 200,
                    )
                  : Container(
                      child: Text('T'),
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
              )
            ],
          ),
        ),
      ),
      // Column(
      //   children: <Widget>[
      //     Padding(
      //       padding: const EdgeInsets.all(8.0),
      //       child: (imageUrl != null)
      //           ? Image.network(imageUrl)
      //           : Placeholder(
      //               fallbackHeight: 200.0,
      //               fallbackWidth: double.infinity,
      //             ),
      //     ),
      //     SizedBox(
      //       height: 20,
      //     ),
      //     RaisedButton(
      //       child: Text('Upload Image'),
      //       color: Colors.orange,
      //       onPressed: () => uploadImage(),
      //     )
      //   ],
      // ),
    );
  }

  uploadImage() async {
    // final _storage = FirebaseStorage.instance;
    // final _picker = ImagePicker();
    // PickedFile image;
    //Check Permission
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
