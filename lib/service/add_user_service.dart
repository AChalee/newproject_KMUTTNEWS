import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

String fname = '',
    lname = '',
    urlImage = '',
    years = '',
    faculty = '',
    branch = '';

Future<void> userSetup(String displayName, email) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  String uid = auth.currentUser.uid.toString();
  CollectionReference users = FirebaseFirestore.instance.collection('Users');

  FirebaseFirestore.instance.collection("Users").document(uid).setData({
    'displayName': displayName,
    'uid': uid,
    'email': email,
    'fname': fname,
    'lname': lname,
    'years': years,
    'faculty': faculty,
    'branch': branch,
    'UrlImage': urlImage,
  });
  return;
}
