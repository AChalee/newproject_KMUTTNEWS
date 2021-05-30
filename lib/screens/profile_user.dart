import 'package:flutter/material.dart';
import 'dart:async';

import 'package:image_picker/image_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//import 'package:New_Project_KMUTTNEWS/screens/editProfile.dart';
import 'package:New_Project_KMUTTNEWS/screens/login_view.dart';

import 'edit_profile_user.dart';

class Profile extends StatefulWidget {
  @override
  ProfileState createState() => ProfileState();
}

class ProfileState extends State<Profile> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  //bool circular = false;
  PickedFile _imageFile;
  final formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();

  final Future<FirebaseApp> firebase = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontFamily: 'Itim',
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.keyboard,
              color: Colors.white,
            ),
            onPressed: () {
              auth.signOut().then((value) {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                  return Login();
                }));
              });
            },
          ),
        ],
      ),
      // backgroundColor: Colors.deepOrange[100],

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
          fnameText(),
          SizedBox(height: 5),
          showFName(),
          SizedBox(height: 15),
          lnameText(),
          SizedBox(height: 5),
          showLName(),
          SizedBox(height: 15),
          emailText(),
          SizedBox(height: 5),
          showEmail(),
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
        style: TextStyle(
          fontSize: 10,
          fontFamily: 'Itim',
          color: Colors.grey,
        ),
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
                    padding: EdgeInsets.fromLTRB(25, 15, 0, 0),
                    child: Text(
                      document["displayName"],
                      style: TextStyle(
                        fontSize: 11,
                        fontFamily: 'Itim',
                        color: Colors.grey[400],
                      ),
                    ),
                  );
                }).toList(),
              ),
            );
          }),
    );
  }

  Widget fnameText() {
    return Container(
      // margin: EdgeInsets.only(right: 250.0),
      child: Text(
        "FistName : ",
        //textAlign: TextAlign.right,
        style: TextStyle(
          fontSize: 10,
          fontFamily: 'Itim',
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget lnameText() {
    return Container(
      // margin: EdgeInsets.only(right: 250.0),
      child: Text(
        "LastName : ",
        //textAlign: TextAlign.right,
        style: TextStyle(
          fontSize: 10,
          fontFamily: 'Itim',
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget showFName() {
    return Container(
      height: 45,
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
                    padding: EdgeInsets.fromLTRB(25, 15, 0, 0),
                    child: Text(
                      document["fname"],
                      style: TextStyle(
                        fontSize: 11,
                        fontFamily: 'Itim',
                        color: Colors.grey[400],
                      ),
                    ),
                  );
                }).toList(),
              ),
            );
          }),
    );
  }

  Widget showLName() {
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
                    padding: EdgeInsets.fromLTRB(25, 15, 0, 0),
                    child: Text(
                      document["lname"],
                      style: TextStyle(
                        fontSize: 11,
                        fontFamily: 'Itim',
                        color: Colors.grey[400],
                      ),
                    ),
                  );
                }).toList(),
              ),
            );
          }),
    );
  }

  Widget emailText() {
    return Container(
      margin: EdgeInsets.only(right: 250.0),
      child: Text(
        "Email : ",
        //textAlign: TextAlign.right,
        style: TextStyle(
          fontSize: 10,
          fontFamily: 'Itim',
          color: Colors.grey,
        ),
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
                border: Border.all(
                  color: Colors.grey[200],
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: ListView(
                children: snapshot.data.docs.map((document) {
                  return Container(
                    padding: EdgeInsets.fromLTRB(25, 15, 0, 0),
                    child: Text(
                      document["email"],
                      style: TextStyle(
                        fontSize: 11,
                        fontFamily: 'Itim',
                        color: Colors.grey[400],
                      ),
                    ),
                  );
                }).toList(),
              ),
            );
          }),
    );
  }

  Widget yearsBranchText() {
    return Row(
      children: [
        Container(
          child: Text(
            "Years : ",
            style: TextStyle(
              fontSize: 10,
              fontFamily: 'Itim',
              color: Colors.grey,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 50.0),
          child: Text(
            "Branch : ",
            style: TextStyle(
              fontSize: 10,
              fontFamily: 'Itim',
              color: Colors.grey,
            ),
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
                  width: 80,
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
                        padding: EdgeInsets.fromLTRB(25, 15, 0, 0),
                        child: Text(
                          document["years"],
                          style: TextStyle(
                            fontSize: 11,
                            fontFamily: 'Itim',
                            color: Colors.grey[400],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                );
              }),
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
                  width: 200,
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
                        padding: EdgeInsets.fromLTRB(25, 15, 0, 0),
                        child: Text(
                          document["branch"],
                          style: TextStyle(
                            fontSize: 11,
                            fontFamily: 'Itim',
                            color: Colors.grey[400],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                );
              }),
        ),
      ],
    );
  }

  Widget facultyText() {
    return Container(
      margin: EdgeInsets.only(right: 200.0),
      child: Text(
        "Faculty : ",
        //textAlign: TextAlign.right,
        style: TextStyle(
          fontSize: 10,
          fontFamily: 'Itim',
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget showFaculty() {
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
                    padding: EdgeInsets.fromLTRB(25, 15, 0, 0),
                    child: Text(
                      document["faculty"],
                      style: TextStyle(
                        fontSize: 11,
                        fontFamily: 'Itim',
                        color: Colors.grey[400],
                      ),
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

  Widget imageProfile() {
    return Center(
      child: Stack(children: <Widget>[
        Container(
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("Users")
                .where('uid', isEqualTo: auth.currentUser.uid)
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  final DocumentSnapshot item = snapshot.data.documents[index];
                  return Center(
                    child: Stack(children: <Widget>[
                      CircleAvatar(
                        radius: 70,
                        backgroundImage: NetworkImage(item['UrlImage']),
                        // fit: BoxFit.fill
                      ),
                    ]),
                  );
                },
              );
            },
          ),
        ),
      ]),
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            "Choose Profile photo",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.camera),
              onPressed: () {
                takePhoto(ImageSource.camera);
              },
              label: Text("Camera"),
            ),
            FlatButton.icon(
              icon: Icon(Icons.image),
              onPressed: () {
                takePhoto(ImageSource.gallery);
              },
              label: Text("Gallery"),
            ),
          ])
        ],
      ),
    );
  }

  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(
      source: source,
    );
    setState(() {
      _imageFile = pickedFile;
    });
  }

  Widget registerButton(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      color: Colors.orange[500],
      //padding: EdgeInsets.all(15),
      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
      child: Text(
        "Edit Profile",
        style: TextStyle(
            color: Colors.white,
            fontSize: 13,
            fontFamily: 'Itim',
            fontWeight: FontWeight.bold),
      ),
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => EditProfile()));
      },
    );
  }
}
