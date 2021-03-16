import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'package:New_Project_KMUTTNEWS/screens/login_view.dart';
//import 'package:New_Project_KMUTTNEWS/tabview/login_tab_view.dart';

class RegisterTabView extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  String nameString, emailString, passwordString;

  var selectedYear;
  List<String> year = <String>['ปี 1', 'ปี 2', 'ปี 3', 'ปี 4'];

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
                  nameText(),
                  SizedBox(height: 15),
                  emailText(),
                  SizedBox(height: 15),
                  passwordText(),
                  SizedBox(height: 5),
                  clearButton(),
                  SizedBox(height: 10),
                  registerButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget nameText() {
    return TextFormField(
      style: TextStyle(fontSize: 12, fontFamily: 'Itim'),
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey[200], width: 2),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        labelText: 'Name',
        labelStyle: TextStyle(
          color: Colors.grey,
        ),
      ),
      validator: (String value) {
        if (value.isEmpty) {
          return '';
        } else {
          return null;
        }
      },
      onSaved: (String value) {
        nameString = value.trim();
      },
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
          return '';
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
          return '';
        } else {
          return null;
        }
      },
      onSaved: (String value) {
        passwordString = value.trim();
      },
    );
  }

  Widget clearButton() {
    return FlatButton(
      child: Text(
        "Clear",
        style: TextStyle(
          color: Colors.grey,
          fontSize: 11,
          fontFamily: 'Itim',
        ),
      ),
      onPressed: () {
        formKey.currentState.reset();
      },
    );
  }

  Widget registerButton() {
    return RaisedButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      color: Colors.orange[500],
      padding: EdgeInsets.symmetric(horizontal: 60, vertical: 10),
      child: Text(
        "REGISTER",
        style: TextStyle(
            color: Colors.white,
            fontSize: 13,
            fontFamily: 'Itim',
            fontWeight: FontWeight.bold),
      ),
      onPressed: () {
        if (formKey.currentState.validate()) {
          formKey.currentState.save();
          formKey.currentState.reset();
          print(
              'name = $nameString, email =$emailString, password = $passwordString');
          registerThread(); //ถ้าเมื่อไรที่ได้ค่า name email pass ให้ไปทำงานที่  registerThread()
          print(nameString + emailString + passwordString);

          // Login();
        }
      },
    );
  }

  Future<void> registerThread() async {
    // await Firebase.initializeApp();
    print('RegisterThread');

    //สร้าง instance ชื่อ firebaseAuth เพื่อให้มันไป call method ที่อยู่ใน plugin หรือ library มาทำงาน
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance; //firebase
    await firebaseAuth //await คือต้องทำงานให้สำเร็จ
        .createUserWithEmailAndPassword(
            email: emailString, password: passwordString)
        .then((response) {
      //ถ้าไปสร้างใน au สำเร็จแล้วให้ return response กลับมา print...
      print('Register Success for Email = $emailString');
      //   setupDisplayName(); //เมื่อไรที่สมัครสมาชิกสำเร็จ ให้ call setupDisplayName ให้ทำงาน
    }).catchError((response) {
      print('เข้า EROR');
      //catchError ทำต่อเมื่อ เราทำผิดกฎการสมัคร
      String title = response.code; //เอาresponse มาแกะ ว่าผิดอะไร
      String message = response.message;
      print('title = $title, message=$message');
    });
  }
}
