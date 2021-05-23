import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:New_Project_KMUTTNEWS/screens/news_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
//import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

//import 'package:New_Project_KMUTTNEWS/provider/firebase_auth.dart';

//import 'package:New_Project_KMUTTNEWS/tabview/register_tab_view.dart';

class LoginTabView extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  String nameString, emailString, passwordString;
  //final Future<FirebaseApp> firebase = Firebase.initializeApp();

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = new GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomPadding: false, //แก้ปัญหาขึ้น Bottom Overflowed
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Form(
          key: formKey,
          child: Container(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 50),
                  emailText(),
                  SizedBox(height: 15),
                  passwordText(),
                  SizedBox(height: 15),
                  forgotPassword(),
                  SizedBox(height: 10),
                  registerButton(context),
                  SizedBox(height: 15),
                  textContinue(),
                  SizedBox(height: 15),
                  signUpGoogle(context),
                  SizedBox(height: 12),
                  // signUpFacebook(context),
                  // SizedBox(height: 12),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget emailText() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(fontSize: 12, fontFamily: 'Itim'),
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey[200], width: 2),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        labelText: 'Email',
        labelStyle: TextStyle(
          color: Colors.grey,
        ),
      ),
      validator: (String value) {
        if (!((value.contains('@')) && (value.contains('.')))) {
          return 'Please Enter Value Email';
        } else {
          return null;
        }
      },
      onSaved: (String value) {
        emailString = value.trim();
      },
    );
  }

  Widget passwordText() {
    return TextFormField(
      obscureText: true, //ปิดบัง password
      style: TextStyle(fontSize: 12, fontFamily: 'Itim'),
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey[200], width: 2),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        labelText: 'Password',
        labelStyle: TextStyle(
          color: Colors.grey,
        ),
      ),
      validator: (String value) {
        if (value.length < 6) {
          return 'Please must be least 6 charactors';
        } else {
          return null;
        }
      },
      onSaved: (String value) {
        passwordString = value.trim();
      },
    );
  }

  Widget forgotPassword() {
    return Text(
      "Forgot Password?",
      style: TextStyle(
        fontSize: 12,
        fontFamily: 'Itim',
        color: Colors.grey,
      ),
    );
  }

  Widget textContinue() {
    return Text(
      "Continue with social media",
      style: TextStyle(
        fontSize: 12,
        fontFamily: 'Itim',
        color: Colors.grey,
      ),
    );
  }

  Widget registerButton(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      color: Colors.orange[500],
      padding: EdgeInsets.symmetric(horizontal: 60, vertical: 10),
      child: Text(
        "LOGIN",
        style: TextStyle(
            color: Colors.white,
            fontSize: 13,
            fontFamily: 'Itim',
            fontWeight: FontWeight.bold),
      ),
      onPressed: () {
        if (formKey.currentState.validate()) {
          formKey.currentState.save();
          registerThread(
              context); //ถ้าเมื่อไรที่ได้ค่า name email pass ให้ไปทำงานที่  registerThread()
        }
      },
    );
  }

  Future<void> registerThread(context) async {
    // await Firebase.initializeApp();
    print('RegisterThread');

    //สร้าง instance ชื่อ firebaseAuth เพื่อให้มันไป call method ที่อยู่ใน plugin หรือ library มาทำงาน
    //  final FirebaseAuth firebaseAuth = FirebaseAuth.instance; //firebase
    await firebaseAuth //await คือต้องทำงานให้สำเร็จ
        .signInWithEmailAndPassword(
            email: emailString, password: passwordString)
        .then((response) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => News()));

      Fluttertoast.showToast(
          msg: "Login Success", gravity: ToastGravity.TOP); //alert
    }).catchError((response) {
      print('เข้า EROR');
      Fluttertoast.showToast(msg: "Try again", gravity: ToastGravity.TOP);
    });
  }

  Widget signUpGoogle(BuildContext context) {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    final GoogleSignIn googleSignIn = new GoogleSignIn();
    return OutlineButton.icon(
      label: Text(
        'Sign In With Google',
        style: TextStyle(
          color: Colors.black,
          fontSize: 10,
          fontFamily: 'Itim',
        ),
      ),
      shape: StadiumBorder(),
      padding: EdgeInsets.symmetric(horizontal: 22, vertical: 8),
      borderSide: BorderSide(color: Colors.black),
      icon: FaIcon(FontAwesomeIcons.google, color: Colors.red),
      onPressed: () async {
        signInWithGoogle(context);
      },
    );
  }

  Future signInWithGoogle(BuildContext context) async {
    GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: [
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );
    GoogleSignInAccount user = await _googleSignIn.signIn();
    GoogleSignInAuthentication userAuth = await user.authentication;

    await firebaseAuth.signInWithCredential(GoogleAuthProvider.getCredential(
        idToken: userAuth.idToken, accessToken: userAuth.accessToken));
//    checkAuth(context); // after success route to home.
  }
}
