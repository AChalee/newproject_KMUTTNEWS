import 'package:New_Project_KMUTTNEWS/constants.dart';
import 'package:New_Project_KMUTTNEWS/screens/profile_user.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:math';
import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
//import 'package:New_Project_KMUTTNEWS/screens/login_view.dart';
//import 'package:New_Project_KMUTTNEWS/screens/Profile.dart';

class EditProfile extends StatefulWidget {
  @override
  EditProfileState createState() => EditProfileState();
}

class EditProfileState extends State<EditProfile> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final Future<FirebaseApp> firebase = Firebase.initializeApp();

  bool circular = false;
  String nameString = '',
      fnameString = '',
      lnameString = '',
      emailString = '',
      passwordString = '',
      displayString = '',
      urlImage = '';

  var selectYear, selectBranch, selectFaculty;

  File imageFile, newProfilePic;
  var imageFiles = [];

  final formKey = GlobalKey<FormState>();

  List<String> year = <String>['ปี 1', 'ปี 2', 'ปี 3', 'ปี 4'];
  List<String> faculty = <String>[
    'คณะวิศวกรรมศาสตร์',
    'คณะวิทยาศาสตร์',
    'คณะครุศาสตร์อุตสาหกรรม',
    'คณะเทคโนโลยีสารสนเทศ',
    'คณะสถาปัตยกรรมศาสตร์',
    'สถาบันวิทยาการหุ่นยนต์ภาคสนาม'
  ];

  List<String> branch = <String>[
    'วิศวกรรมคอม',
    'วิศวกรรมเคมี',
    'วิศวกรรมเครื่องกล',
    'วิศวกรรมไฟฟ้า',
    'วิศวกรรมโยธา',
    'วิศวกรรมอุต',
    'วิศวกรรมเมคา',
    'วิศวกรรมสิ่งแวดล้อม',
    'วิศวกรรมเครื่องมือ',
  ];

  Widget build(BuildContext context) {
   // final FirebaseFirestore fb = FirebaseFirestore.instance;

    /////////////////////////////
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit-Profile",
          style: TextStyle(
              fontSize: 24,
              fontFamily: 'Prompt',
              color: Colors.white,
              fontStyle: FontStyle.italic
          ),
        ),

      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        children: <Widget>[
          SizedBox(height: 20),
          imageProfile(),
          SizedBox(height: 25),
          displayText(),
          SizedBox(height: 5),
          showDisplayName(),
          SizedBox(height: 15),
          emailText(),
          SizedBox(height: 5),
          showEmail(),
          SizedBox(height: 30),
          otherText(),
          SizedBox(height: 18),
          fnameText(),
          SizedBox(height: 5),
          showFName(),
          SizedBox(height: 15),
          lnameText(),
          SizedBox(height: 5),
          showLName(),
          SizedBox(height: 15),
          yearsBranchText(),
          SizedBox(height: 5),
          yearsBranchShow(),
          SizedBox(height: 15),
          facultyText(),
          SizedBox(height: 5),
          showFaculty(),
          SizedBox(height: 25),
          registerButton(context),
          SizedBox(height: 50),
        ],
      ),
    );
  }

  Widget displayText() {
    return Container(
      margin: EdgeInsets.only(right: 200.0),
      child: Text(
        "DisplayName : ",
        //textAlign: TextAlign.right,
        style: descriptionStyle
      ),
    );
  }

  Widget showDisplayName() {
    return Container(
      height: 45,
      child: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance
              .collection("Users")
              .where('uid', isEqualTo: auth.currentUser.uid)
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            return Container(
              width: 300,
              height: 60,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey[200],
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: ListView(
                children: snapshot.data.docs.map((document) {
                  return Container(
                    padding: EdgeInsets.fromLTRB(25, 8, 0, 0),
                    child: Text(
                      document["displayName"],
                      style: kDetailContent
                    ),
                  );
                }).toList(),
              ),
            );
          }),
    );
  }

  Widget otherText() {
    return Container(
      margin: EdgeInsets.only(),
      child: Text(
        "----------------  Edit Profile  ----------------",
        //textAlign: TextAlign.right,
        style: descriptionStyle
      ),
    );
  }

  Widget fnameText() {
    return Container(
      child: Text(
        "FistName : ",
        //textAlign: TextAlign.right,
        style: descriptionStyle      ),
    );
  }

  Widget lnameText() {
    return Container(
      child: Text(
        "LastName : ",
        style: descriptionStyle
      ),
    );
  }

  Widget showFName() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: 45,
          width: 270,
          child: StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance
                  .collection("Users")
                  .where('uid', isEqualTo: auth.currentUser.uid)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                return Container(
                  height: 60,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey[200],
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: ListView(
                    children: snapshot.data.docs.map((document) {
                      return Container(
                        padding: EdgeInsets.fromLTRB(25, 10, 0, 0),
                        child: Text(
                          document["fname"],
                          style: kDetailContent
                        ),
                      );
                    }).toList(),
                  ),
                );
              }),
        ),
        InkWell(
          child: Container(
            child: Icon(
              Icons.edit,
              color: Colors.grey[400],
              size: 22.0,
            ),
          ),
          onTap: () {
            _showFName(context);
          },
        ),
      ],
    );
  }

  Future<void> _showFName(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'FirestName',
              style: descriptionStyle
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Container(
                    height: 45,
                    child: TextFormField(
                      style: TextStyle(fontSize: 11, fontFamily: 'Itim'),
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey[200], width: 2),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: Colors.orange,
                          width: 2,
                        )),
                        hintText: "XoXo",
                        labelStyle: TextStyle(color: Colors.grey),
                        hintStyle: TextStyle(color: Colors.grey[200]),
                      ),
                      onChanged: (selectedAccountType) {
                        print('$selectedAccountType');
                        setState(() {
                          fnameString = selectedAccountType;
                        });
                        print(fnameString);
                      },
                    ),
                  ),
                  SizedBox(height: 15),
                  saveFName(context),
                ],
              ),
            ),
          );
        });
  }

  Widget saveFName(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      color: Colors.orange[500],
      padding: EdgeInsets.symmetric(horizontal: 60, vertical: 10),
      child: Text(
        " Save ",
        style: kTitleCard
      ),
      onPressed: () {
        updateFName();
      },
    );
  }

///////////////////////////////////////////
  Future<void> updateF() async {
    StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance
            .collection("Users")
            .where('uid', isEqualTo: auth.currentUser.uid)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          return Container(
            child: ListView(
              children: snapshot.data.docs.map((document) {
                return Container(
                  child: Text(
                    document["fname"],
                    style: kDetailContent
                  ),
                );
              }).toList(),
            ),
          );
        });
  }

  Future<void> updateFName() async {
    Map<String, dynamic> updateUser = new Map<String, dynamic>();
    updateUser['fname'] = fnameString;
    Firestore.instance
        .collection("Users")
        .document(auth.currentUser.uid)
        .updateData(updateUser)
        .whenComplete(() {});
    print(auth.currentUser.uid);
  }

  ///////////////////////////////////////////////////////
///////////////////////////////////////////////////////
///////////////////////////////////////////////////////

  Widget showLName() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: 45,
          width: 270,
          child: StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance
                  .collection("Users")
                  .where('uid', isEqualTo: auth.currentUser.uid)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                return Container(
                  width: 300,
                  height: 60,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey[200],
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: ListView(
                    children: snapshot.data.docs.map((document) {
                      return Container(
                        padding: EdgeInsets.fromLTRB(25, 10, 0, 0),
                        child: Text(
                          document["lname"],
                          style: kDetailContent
                        ),
                      );
                    }).toList(),
                  ),
                );
              }),
        ),
        InkWell(
          child: Container(
            child: Icon(
              Icons.edit,
              color: Colors.grey[400],
              size: 22.0,
            ),
          ),
          onTap: () {
            _showLName(context);
          },
        ),
      ],
    );
  }

  Future<void> _showLName(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'LastName',
              style: kDetailContent
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Container(
                    height: 45,
                    child: TextFormField(
                      style: TextStyle(fontSize: 11, fontFamily: 'Itim'),
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey[200], width: 2),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: Colors.orange,
                          width: 2,
                        )),
                        hintText: "XoXo",
                        labelStyle: TextStyle(color: Colors.grey),
                        hintStyle: TextStyle(color: Colors.grey[200]),
                      ),
                      onChanged: (selectedAccountType) {
                        print('$selectedAccountType');
                        setState(() {
                          lnameString = selectedAccountType;
                        });
                        print(lnameString);
                      },
                    ),
                  ),
                  SizedBox(height: 15),
                  saveLName(context),
                ],
              ),
            ),
          );
        });
  }

  Widget saveLName(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      color: Colors.orange[500],
      padding: EdgeInsets.symmetric(horizontal: 60, vertical: 10),
      child: Text(
        " Save ",
        style: kDetailContent
      ),
      onPressed: () {
        updateLName();
      },
    );
  }

  Future<void> updateLName() async {
    Map<String, dynamic> updateUser = new Map<String, dynamic>();
    updateUser['lname'] = lnameString;
    Firestore.instance
        .collection('Users')
        .document(auth.currentUser.uid)
        .updateData(updateUser)
        .whenComplete(() {});
  }
  //////////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////

  Widget emailText() {
    return Container(
      margin: EdgeInsets.only(right: 250.0),
      child: Text(
        "Email : ",
        //textAlign: TextAlign.right,
        style: descriptionStyle
      ),
    );
  }

  Widget showEmail() {
    return Container(
      height: 45,
      child: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance
              .collection("Users")
              .where('uid', isEqualTo: auth.currentUser.uid)
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            return Container(
              width: 300,
              height: 60,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[200], width: 1),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: ListView(
                children: snapshot.data.docs.map((document) {
                  return Container(
                    padding: EdgeInsets.fromLTRB(25, 8, 0, 0),
                    child: Text(
                      document["email"],
                      style: kDetailContent
                    ),
                  );
                }).toList(),
              ),
            );
          }),
    );
  }

  //////////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////

  Widget yearsBranchText() {
    return Row(
      children: [
        Container(
          child: Text(
            "Years : ",
            style: descriptionStyle          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 70.0),
          child: Text(
            "Branch : ",
            style: descriptionStyle
          ),
        ),
      ],
    );
  }

  Widget yearsBranchShow() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: 45,
          child: StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance
                  .collection("Users")
                  .where('uid', isEqualTo: auth.currentUser.uid)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                return Container(
                  width: 70,
                  height: 45,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey[200],
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: ListView(
                    children: snapshot.data.docs.map((document) {
                      return Container(
                        padding: EdgeInsets.fromLTRB(15, 12, 0, 0),
                        child: Text(
                          document["years"],
                          style: kDetailContent
                        ),
                      );
                    }).toList(),
                  ),
                );
              }),
        ),
        InkWell(
          child: Container(
            child: Icon(
              Icons.edit,
              color: Colors.grey[400],
              size: 20.0,
            ),
          ),
          onTap: () {
            _showYear(context);
          },
        ),
        Container(
          height: 45,
          child: StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance
                  .collection("Users")
                  .where('uid', isEqualTo: auth.currentUser.uid)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                return Container(
                  width: 150,
                  height: 60,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey[200],
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: ListView(
                    children: snapshot.data.docs.map((document) {
                      return Container(
                        padding: EdgeInsets.fromLTRB(15, 12, 0, 0),
                        child: Text(
                          document["branch"],
                          style: kDetailContent
                        ),
                      );
                    }).toList(),
                  ),
                );
              }),
        ),
        InkWell(
          child: Container(
            child: Icon(
              Icons.edit,
              color: Colors.grey[400],
              size: 20.0,
            ),
          ),
          onTap: () {
            _showBranch(context);
          },
        ),
      ],
    );
  }

  Future<void> _showYear(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Year',
              style: kDetailContent
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Container(
                    width: 80,
                    height: 45,
                    padding: EdgeInsets.fromLTRB(25, 0, 0, 0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[400], width: 2),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        items: year
                            .map((value) => DropdownMenuItem(
                                  child: Text(
                                    value,
                                    style: kDetailContent
                                  ),
                                  value: value,
                                ))
                            .toList(),
                        onChanged: (selectedAccountType) {
                          print('$selectedAccountType');
                          setState(() {
                            selectYear = selectedAccountType;
                          });
                          print(selectYear);
                        },
                        value: selectYear,
                        isExpanded: false,
                        hint: Text(
                          'ปี',
                          style: kDetailContent
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  saveYear(context),
                ],
              ),
            ),
          );
        });
  }

  Widget saveYear(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      color: Colors.orange[500],
      padding: EdgeInsets.symmetric(horizontal: 60, vertical: 10),
      child: Text(
        " Save ",
        style: kTitleCard
      ),
      onPressed: () {
        updateYear();
      },
    );
  }

  Future<void> updateYear() async {
    Map<String, dynamic> updateUser = new Map<String, dynamic>();
    updateUser['years'] = selectYear;

    Firestore.instance
        .collection('Users')
        .document(auth.currentUser.uid)
        .updateData(updateUser)
        .whenComplete(() {});
  }

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////
  Future<void> _showBranch(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Branch',
              style: kDetailContent
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Container(
                    width: 80,
                    height: 45,
                    padding: EdgeInsets.fromLTRB(25, 0, 0, 0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[400], width: 2),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        items: branch
                            .map((value) => DropdownMenuItem(
                                  child: Text(
                                    value,
                                    style: kDetailContent
                                  ),
                                  value: value,
                                ))
                            .toList(),
                        onChanged: (selectedAccountType) {
                          print('$selectedAccountType');
                          setState(() {
                            selectBranch = selectedAccountType;
                          });
                          print(selectBranch);
                        },
                        value: selectYear,
                        isExpanded: false,
                        hint: Text(
                          'สาขาวิชา',
                          style: kDetailContent                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  saveBranch(context),
                ],
              ),
            ),
          );
        });
  }

  Widget saveBranch(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      color: Colors.orange[500],
      padding: EdgeInsets.symmetric(horizontal: 60, vertical: 10),
      child: Text(
        " Save ",
        style: kTitleCard
      ),
      onPressed: () {
        updateBranch();
      },
    );
  }

  Future<void> updateBranch() async {
    Map<String, dynamic> updateUser = new Map<String, dynamic>();
    updateUser['branch'] = selectBranch;

    Firestore.instance
        .collection('Users')
        .document(auth.currentUser.uid)
        .updateData(updateUser)
        .whenComplete(() {});
  }

  //////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

  Widget facultyText() {
    return Container(
      margin: EdgeInsets.only(right: 200.0),
      child: Text(
        "Faculty : ",
        //textAlign: TextAlign.right,
        style: descriptionStyle
      ),
    );
  }

  Widget showFaculty() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: 45,
          width: 270,
          child: StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance
                  .collection("Users")
                  .where('uid', isEqualTo: auth.currentUser.uid)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                return Container(
                  width: 300,
                  height: 60,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey[200],
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: ListView(
                    children: snapshot.data.docs.map((document) {
                      return Container(
                        padding: EdgeInsets.fromLTRB(25, 12, 0, 0),
                        child: Text(
                          document["faculty"],
                          style: kDetailContent
                        ),
                      );
                    }).toList(),
                  ),
                );
              }),
        ),
        InkWell(
          child: Container(
            child: Icon(
              Icons.edit,
              color: Colors.grey[400],
              size: 20.0,
            ),
          ),
          onTap: () {
            _showFaculty(context);
          },
        ),
      ],
    );
  }

  Future<void> _showFaculty(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Faculty',
              style: kDetailContent
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Container(
                    width: 80,
                    height: 45,
                    padding: EdgeInsets.fromLTRB(25, 0, 0, 0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[400], width: 2),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        items: faculty
                            .map((value) => DropdownMenuItem(
                                  child: Text(
                                    value,
                                    style: kDetailContent
                                  ),
                                  value: value,
                                ))
                            .toList(),
                        onChanged: (selectedAccountType) {
                          print('$selectedAccountType');
                          setState(() {
                            selectFaculty = selectedAccountType;
                          });
                          print(selectFaculty);
                        },
                        value: selectFaculty,
                        isExpanded: false,
                        hint: Text(
                          'คณะ',
                          style: kDetailContent
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  saveFaculty(context),
                ],
              ),
            ),
          );
        });
  }

  Widget saveFaculty(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      color: Colors.orange[500],
      padding: EdgeInsets.symmetric(horizontal: 60, vertical: 10),
      child: Text(
        " Save ",
        style: kTitleCard
      ),
      onPressed: () {
        updateFaculty();
      },
    );
  }

  Future<void> updateFaculty() async {
    Map<String, dynamic> updateUser = new Map<String, dynamic>();
    updateUser['faculty'] = selectFaculty;
    Firestore.instance
        .collection('Users')
        .document(auth.currentUser.uid)
        .updateData(updateUser)
        .whenComplete(() {});
  }

/////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////
  Widget imageProfile() {
    return Center(
      child: Stack(children: <Widget>[
        CircleAvatar(
          radius: 70.0,
          backgroundImage: imageFile == null
              ? AssetImage("assets/image/addImage.png")
              : FileImage(File(imageFile.path)),
        ),
        Positioned(
          bottom: 20.0,
          right: 20.0,
          child: InkWell(
            onTap: () {
              _showChoiceDialog(context);
            },
            child: Icon(
              Icons.camera_alt,
              color: Colors.white,
              size: 28.0,
            ),
          ),
        ),
      ]),
    );
  }

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Choose Profile photo',
              style: kDetailContent
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: Text(
                      'Camera',
                      style: kDetailContent
                    ),
                    onTap: () {
                      _openCamera(ImageSource.camera);
                    },
                  ),
                  Padding(padding: EdgeInsets.all(8)),
                  GestureDetector(
                    child: Text(
                      'Gallery',
                      style: kDetailContent
                    ),
                    onTap: () {
                      _openGallary(context);

                      //  takePhoto(ImageSource.gallery);
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  _openGallary(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
    this.setState(() {
      imageFile = picture;
      this.imageFiles.add(picture);
    });
    Navigator.of(context).pop();
  }

  _openCamera(ImageSource imageSource) async {
    var picture = await ImagePicker.pickImage(source: imageSource);
    setState(() {
      imageFile = picture;
      this.imageFiles.add(picture);
    });
    Navigator.of(context).pop();
  }

  Future<void> uploadPicToStorage() async {
    print('ตอนนี้อยู่ใน uploadPicToStorage');
    Random random = Random();
    int i = random.nextInt(100000);

    FirebaseStorage firebaseStorage = FirebaseStorage.instance;
    StorageReference storageReference =
        firebaseStorage.ref().child('UserPhoto//UserPhoto$i.jpg');
    StorageUploadTask storageUploadTask = storageReference.putFile(imageFile);

    urlImage = await (await storageUploadTask.onComplete).ref.getDownloadURL();
    print('NewsPhoto is = $urlImage');
    updateUser();
  }

  Widget registerButton(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      color: Colors.orange[500],
      padding: EdgeInsets.symmetric(horizontal: 60, vertical: 10),
      child: Text(
        " Save ",
        style: kTitleCard
      ),
      onPressed: () {
        print("เข้า firebase ไหมน้าาา");
        uploadPicToStorage();
        updateUser();
        print("ออก insertinformation");

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Profile(),
          ),
        );
      },
    );
  }

  Future<void> updateUser() async {
    Map<String, dynamic> updateUser = new Map<String, dynamic>();
    updateUser['UrlImage'] = urlImage;

    Firestore.instance
        .collection('Users')
        .document(auth.currentUser.uid)
        .updateData(updateUser)
        .whenComplete(() {});
  }
}
