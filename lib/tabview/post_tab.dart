// import 'package:firebase_core/firebase_core.dart';
// // import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';
// import 'dart:io';
// import 'dart:math';
// import 'dart:async';
// import 'package:path/path.dart' as Path;
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// //import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// // import 'package:firebase_core/firebase_core.dart';
// // import 'package:flutter_form_bloc/flutter_form_bloc.dart';
// //import 'package:newlaundry/widgets/pickimage.dart';

// class AddData extends StatefulWidget {
//   @override
//   AddDataState createState() => AddDataState();
// }

// class AddDataState extends State<AddData> {
//   File imageFile, file;
//   String topic, detail, urlImage;
//   String faculty, branch;

//   var imageFiles = [];

//   //////////////////////////
//   var selectedCategory, selectedType;
//   final GlobalKey<FormState> _formKeyValue = new GlobalKey<FormState>();
//   List<String> types = <String>['ข่าวสาร', 'กิจกรรม'];
//   List<String> categorys = <String>[
//     'ประกาศจากมหาวิทยาลัย',
//     'กิจกรรม Freshy',
//     'งานดนตรี',
//     'งานตลาด'
//   ];
//   /////////////////////////

//   _openGallary(BuildContext context) async {
//     var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
//     this.setState(() {
//       imageFile = picture;
//       this.imageFiles.add(picture);
//     });
//     Navigator.of(context).pop();
//   }

//   _openCamera(ImageSource imageSource) async {
//     var picture = await ImagePicker.pickImage(source: imageSource);
//     setState(() {
//       imageFile = picture;
//       this.imageFiles.add(picture);
//     });
//     Navigator.of(context).pop();
//   }

//   Future<void> _showChoiceDialog(BuildContext context) {
//     return showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text(
//               'ดำเนินการ',
//               style: TextStyle(
//                   color: Colors.black,
//                   fontFamily: 'Prompt',
//                   fontSize: 18,
//                   fontWeight: FontWeight.w700),
//             ),
//             content: SingleChildScrollView(
//               child: ListBody(
//                 children: <Widget>[
//                   GestureDetector(
//                     child: Text(
//                       'รูปภาพ',
//                       style: TextStyle(
//                           color: Colors.black,
//                           fontFamily: 'Prompt',
//                           fontSize: 16,
//                           fontWeight: FontWeight.w300),
//                     ),
//                     onTap: () {
//                       _openGallary(context);
//                     },
//                   ),
//                   Padding(padding: EdgeInsets.all(8)),
//                   GestureDetector(
//                     child: Text(
//                       'กล้องถ่ายรูป',
//                       style: TextStyle(
//                           color: Colors.black,
//                           fontFamily: 'Prompt',
//                           fontSize: 16,
//                           fontWeight: FontWeight.w300),
//                     ),
//                     onTap: () {
//                       _openCamera(ImageSource.camera);
//                     },
//                   )
//                 ],
//               ),
//             ),
//           );
//         });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Post'),
//       ),
//       backgroundColor: Colors.deepOrange[100],
//       body: ListView(
//         children: <Widget>[
//           Padding(
//             padding: EdgeInsets.only(top: 15, left: 15),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: <Widget>[
//                 // IconButton(
//                 //   icon: Icon(Icons.arrow_back_ios),
//                 //   color: Colors.white,
//                 //   onPressed: () {
//                 //     Navigator.pop(context);
//                 //   },
//                 // ),
//               ],
//             ),
//           ),

//           SizedBox(height: 30, width: 30),
//           Container(
//             // child: PickImage(),
// // this part PickImage
//             padding: EdgeInsets.only(left: 30),
//             alignment: Alignment.topLeft,
//             child: Row(
//               children: [
//                 Row(
//                     children: imageFiles
//                         .map(
//                           (url) => new InkWell(
//                             child: Image.file(url, height: 100, width: 100),
//                             onTap: () {
//                               var index = imageFiles.indexOf(url);
//                               _settingModalBottomSheet(context, index);
//                             },
//                           ),
//                         )
//                         .toList()),
//                 Column(
//                   children: [
//                     InkWell(
//                       child: Image.asset('image/addImage.png',
//                           height: 90, width: 90),
//                       onTap: () {
//                         if (imageFiles.length > 0) {
//                           print(imageFiles);
//                         } else {
//                           _showChoiceDialog(context);
//                         }
//                       },
//                     ),
//                   ],
//                 )
//               ],
//             ),
//           ), // finish PickImage part

//           SizedBox(height: 30, width: 30),
//           Container(
//             padding: EdgeInsets.only(left: 30, right: 30),
//             child: Column(
//               children: [
//                 TextField(
//                   onChanged: (String value) {
//                     topic = value.trim();
//                     print('insert topic done');
//                   },
//                   maxLines: null,
//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(),
//                     labelText: 'หัวข้อข่าว',
//                     labelStyle: TextStyle(
//                         color: Colors.black,
//                         fontFamily: 'Prompt',
//                         fontSize: 16,
//                         fontWeight: FontWeight.w400),
//                     prefixIcon: Icon(
//                       Icons.data_usage,
//                       color: Colors.black,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           SizedBox(height: 30, width: 30),
//           Container(
//             padding: EdgeInsets.only(left: 30, right: 30),
//             child: Column(
//               children: [
//                 TextField(
//                   onChanged: (String value) {
//                     detail = value.trim();
//                     print('insert detail done');
//                   },
//                   maxLines: null,
//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(),
//                     labelText: 'รายละเอียดข่าว',
//                     labelStyle: TextStyle(
//                         color: Colors.black,
//                         fontFamily: 'Prompt',
//                         fontSize: 16,
//                         fontWeight: FontWeight.w400),
//                     prefixIcon: Icon(
//                       Icons.import_contacts,
//                       color: Colors.black,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           SizedBox(height: 30, width: 30),
//           Row(
//             //crossAxisAlignment: CrossAxisAlignment.center,
//             // mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               SizedBox(height: 30, width: 30),
//               DropdownButton(
//                 items: types
//                     .map((value) => DropdownMenuItem(
//                           child: Text(
//                             value,
//                             style: TextStyle(color: Colors.black),
//                           ),
//                           value: value,
//                         ))
//                     .toList(),
//                 onChanged: (selectedAccountType) {
//                   print('$selectedAccountType');
//                   setState(() {
//                     selectedType = selectedAccountType;
//                   });
//                   print(selectedType);
//                 },
//                 value: selectedType,
//                 isExpanded: false,
//                 hint: Text(
//                   'ประเภท',
//                   style: TextStyle(color: Colors.black),
//                 ),
//               ),
//               SizedBox(height: 30, width: 30),
//               DropdownButton(
//                 items: categorys
//                     .map((value) => DropdownMenuItem(
//                           child: Text(
//                             value,
//                             style: TextStyle(color: Colors.black),
//                           ),
//                           value: value,
//                         ))
//                     .toList(),
//                 onChanged: (selectedAccountCategorys) {
//                   print('$selectedAccountCategorys');
//                   setState(() {
//                     selectedCategory = selectedAccountCategorys;
//                   });
//                   print(selectedCategory);
//                 },
//                 value: selectedCategory,
//                 isExpanded: false,
//                 hint: Text(
//                   'หมวดหมู่',
//                   style: TextStyle(color: Colors.black),
//                 ),
//               ),
//             ],
//           ),

//           SizedBox(height: 100),
//           Container(
//             padding: EdgeInsets.only(left: 30, right: 30),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 SizedBox(width: 30),
//                 Column(
//                   children: [
//                     Container(
//                       width: 120,
//                       height: 50,
//                       child: RaisedButton(
//                         onPressed: () {
//                           //print('!!!! object is done !!!!');
//                           print("เข้า firebase ไหมน้าาา");
//                           uploadPicToStorage();
//                           insertinformation();
//                           print("ออก insertinformation");
//                           //  sendNotification();
//                           //picimage.currentState.uploadPicToStorage();
//                           //upload();
//                         },
//                         padding: EdgeInsets.all(10),
//                         color: Colors.redAccent,
//                         elevation: 0,
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(30)),
//                         child: Text(
//                           'โพสต์',
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontFamily: 'Prompt',
//                               fontSize: 18,
//                               fontWeight: FontWeight.w300),
//                         ),
//                       ),
//                     ),
//                   ],
//                 )
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void _settingModalBottomSheet(context, index) {
//     print(index);
//     showModalBottomSheet(
//         context: context,
//         builder: (BuildContext bc) {
//           return Container(
//             child: new Wrap(
//               children: <Widget>[
//                 new ListTile(
//                     leading: new Icon(Icons.remove_red_eye),
//                     title: new Text(
//                       'ดู',
//                       style: TextStyle(
//                           color: Colors.black,
//                           fontFamily: 'Prompt',
//                           fontSize: 16,
//                           fontWeight: FontWeight.w300),
//                     ),
//                     onTap: () => {}),
//                 new ListTile(
//                     leading: new Icon(Icons.remove_circle),
//                     title: new Text(
//                       'ลบ',
//                       style: TextStyle(
//                           color: Colors.black,
//                           fontFamily: 'Prompt',
//                           fontSize: 16,
//                           fontWeight: FontWeight.w300),
//                     ),
//                     onTap: () {
//                       setState(() {
//                         imageFiles.removeAt(index);
//                         Navigator.of(context).pop();
//                         deleteImage(urlImage);
//                       });
//                     }),
//               ],
//             ),
//           );
//         });
//   }

//   Future<void> uploadPicToStorage() async {
//     print('ตอนนี้อยู่ใน uploadPicToStorage');
//     Random random = Random();
//     int i = random.nextInt(100000);

//     FirebaseStorage firebaseStorage = FirebaseStorage.instance;
//     StorageReference storageReference =
//         firebaseStorage.ref().child('NewsPhoto/NewsPhoto$i.jpg');
//     StorageUploadTask storageUploadTask = storageReference.putFile(imageFile);

//     urlImage = await (await storageUploadTask.onComplete).ref.getDownloadURL();
//     print('urlImage is = $urlImage');
//     insertinformation();
//   }

// // เอารูปจากไหน ????
//   Future<void> insertinformation() async {
//     print('เข้ามาใน insertinformation() ละ  // ' +
//         topic +
//         '  //  ' +
//         detail +
//         '  //  ' +
//         urlImage +
//         '  //  ' +
//         selectedType +
//         '  //  ' +
//         selectedCategory);
//     final firestore = Firestore.instance;

//     //Firestore firestore = Firestore.instance;

//     Map<String, dynamic> map = Map();
//     map['Topic'] = topic;
//     map['Detail'] = detail;
//     map['UrlImage'] = urlImage;
//     map['Type'] = selectedType;
//     map['Category'] = selectedCategory;
//     await Firebase.initializeApp();
//     await firestore
//         .collection('PostNews')
//         .document()
//         .setData(map)
//         .then((value) {
//       print('insert Successfully');
//     });
//   }

//   Future<void> deleteImage(String urlImage) async {
//     var fileUrl = Uri.decodeFull(Path.basename(urlImage))
//         .replaceAll(new RegExp(r'(\?alt).*'), '');

//     final StorageReference firebaseStorageRef =
//         FirebaseStorage.instance.ref().child(fileUrl);
//     await firebaseStorageRef.delete();
//     print('Successfully deleted $urlImage from storage');
//   }
// }
// //}

import 'package:New_Project_KMUTTNEWS/component/show_notification.dart';
import 'package:New_Project_KMUTTNEWS/service/add_data_service.dart';
import 'package:New_Project_KMUTTNEWS/service/logger_service.dart';
import 'package:flutter/material.dart';

class AddData extends StatefulWidget {
  @override
  _AddDataState createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  final newsTitle = TextEditingController();
  final newsContent = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Post Data"),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    Padding(padding: const EdgeInsets.all(10)),

                    TextFormField(
                      controller: newsTitle,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          hintText: 'หัวข้อข่าวสาร/กิจกรรม',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 32.0)),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 1.0),
                              borderRadius: BorderRadius.circular(5.0))),
                    ),
                    // TextField(
                    //   decoration: InputDecoration(labelText: "tilte"),
                    //   controller: newsTitle,
                    // ),
                    Padding(padding: const EdgeInsets.all(10)),
                    TextField(
                      controller: newsContent,
                      maxLines: 7,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          hintText: 'รายละเอียด',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 32.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 1.0),
                              borderRadius: BorderRadius.circular(5.0))),
                    ),

                    // TextField(
                    //   decoration: InputDecoration(labelText: "content"),
                    //   controller: newsContent,
                    // ),
                    Padding(padding: const EdgeInsets.all(10)),
                    RaisedButton(
                        child: Text("Post"),
                        onPressed: () {
                          if (newsTitle.text == "" || newsContent.text == "") {
                            showMessageBox(context, "ERROR",
                                "Please enter title and content before adding to firebase",
                                actions: [dismissButton(context)]);
                            logger.e("title or content can't be null");
                          } else {
                            addItem(
                                context,
                                {
                                  "title": newsTitle.text,
                                  "content": newsContent.text
                                },
                                newsTitle.text);
                            newsTitle.text = "";
                            newsContent.text = "";
                          }
                        })
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
