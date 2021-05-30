import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:New_Project_KMUTTNEWS/launcher.dart';
import 'package:New_Project_KMUTTNEWS/screens/news_view.dart';
//import 'package:form_field_validator/form_field_validator.dart';
import 'package:New_Project_KMUTTNEWS/service/add_user_service.dart';

//import 'package:New_Project_KMUTTNEWS/models/profile.dart';

class RegisterTabView extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  //String nameString, emailString, passwordString, repasswordString;
  String displayString, emailString, passwordString, repasswordString;

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance; //firebase

  // Profile profile = Profile();
  // final Future<FirebaseApp> firebase = Firebase.initializeApp();

  // var selectedYear;
  // List<String> year = <String>['ปี 1', 'ปี 2', 'ปี 3', 'ปี 4'];

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
                  // SizedBox(height: 15),
                  // repasswordText(),
                  SizedBox(height: 15),
                  SizedBox(height: 5),
                  clearButton(),
                  SizedBox(height: 10),
                  registerButton(context),
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
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.orange,
          width: 2,
        )),
        labelText: 'DisplayName',
        hintText: "XoXo",
        // helperText: "Password can't be empty",

        labelStyle: TextStyle(color: Colors.grey),
        hintStyle: TextStyle(color: Colors.grey[200]),
      ),
      validator: (String value) {
        if (value.isEmpty) {
          return ' Please Enter Name ';
        } else {
          return null;
        }
      },
      onSaved: (String value) {
        displayString = value.trim();
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
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.orange,
          width: 2,
        )),
        labelText: 'Email',
        hintText: "something@example.com",
        // helperText: "Password can't be empty",

        labelStyle: TextStyle(color: Colors.grey),
        hintStyle: TextStyle(color: Colors.grey[200]),
      ),
      validator: (String value) {
        if (value.isEmpty) {
          return ' Please Enter Email ';
        }
        // if (!((value.contains('@')) && (value.contains('.')))) {
        //   return 'Please Enter Value Email';
        // }
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
          return 'Please a valid Email';
        } else {
          return null;
        }
      },
      onSaved: (String value) {
        emailString = value.trim();
        // profile.email = emailString ;
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
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.orange,
          width: 2,
        )),
        labelText: 'Password',
        hintText: "xxxxxxx",
        // helperText: "Password can't be empty",

        labelStyle: TextStyle(color: Colors.grey),
        hintStyle: TextStyle(color: Colors.grey[200]),
      ),

      validator: (String value) {
        if (value.isEmpty) {
          return 'Please a Enter Password';
        }
        if (value.length < 6) {
          return 'Please must be least 6 charactors';
        } else {
          return null;
        }
      },
      onSaved: (String value) {
        passwordString = value.trim();
        // profile.email = passwordString ;
      },
    );
  }

  // Widget repasswordText() {
  //   return TextFormField(
  //     obscureText: true, //ปิดบัง password
  //     style: TextStyle(fontSize: 12, fontFamily: 'Itim'),
  //     decoration: InputDecoration(
  //       enabledBorder: OutlineInputBorder(
  //           borderSide: BorderSide(color: Colors.grey[200], width: 2),
  //           borderRadius: BorderRadius.all(Radius.circular(10))),
  //       hintText: "password",
  //       labelText: 'Re-enter Password',
  //       labelStyle: TextStyle(
  //         color: Colors.grey,
  //       ),
  //       hintStyle: TextStyle(color: Colors.grey[200]),
  //     ),
  //     validator: (String value) {
  //       if (value.isEmpty) {
  //         return 'Please a Re-Enter Password';
  //       }
  //       if (value.length < 6) {
  //         return 'Please must be least 6 charactors';
  //       } else {
  //         return null;
  //       }
  //     },
  //     onSaved: (String value) {
  //       repasswordString = value.trim();
  //       // profile.email = passwordString ;
  //     },
  //   );
  // }

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

  Widget registerButton(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      color: Colors.orange[500],
      padding: EdgeInsets.symmetric(horizontal: 60, vertical: 10),
      child: Text(
        "Create new account",
        style: TextStyle(
            color: Colors.white,
            fontSize: 11,
            fontFamily: 'Itim',
            fontWeight: FontWeight.bold),
      ),
      onPressed: () {
        if (formKey.currentState.validate()) {
          formKey.currentState.save();
          formKey.currentState.reset();
          registerThread(
              context); //ถ้าเมื่อไรที่ได้ค่า name email pass ให้ไปทำงานที่  registerThread()
          print('เข้า insertinformation');
          //  insertinformation(context);

          //insertinformation();
        }
      },
    );
  }

  Future<void> registerThread(context) async {
    // await Firebase.initializeApp();
    print('RegisterThread');
//if((passwordString == repasswordString )
    await Firebase.initializeApp();
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailString,
      password: passwordString,
    );
    User updateUser = FirebaseAuth.instance.currentUser;
    updateUser.updateProfile(displayName: displayString);
    userSetup(displayString, emailString);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Launcher()));

    Fluttertoast.showToast(
        msg: "Register Success", gravity: ToastGravity.TOP); //alert
    print('Register Success for Email = $emailString');
    //   setupDisplayName(); //เมื่อไรที่สมัครสมาชิกสำเร็จ ให้ call setupDisplayName ให้ทำงาน
  }
}
//   Future<void> registerThread(context) async {
//     // await Firebase.initializeApp();
//     print('RegisterThread');

//     //สร้าง instance ชื่อ firebaseAuth เพื่อให้มันไป call method ที่อยู่ใน plugin หรือ library มาทำงาน
//     //  final FirebaseAuth firebaseAuth = FirebaseAuth.instance; //firebase
//     await firebaseAuth //await คือต้องทำงานให้สำเร็จ
//         .createUserWithEmailAndPassword(
//             email: emailString, password: passwordString)
//         .then((response) {
//       //ถ้าไปสร้างใน au สำเร็จแล้วให้ return response กลับมา print...
//       Navigator.push(
//           context, MaterialPageRoute(builder: (context) => Launcher()));

//       Fluttertoast.showToast(
//           msg: "Register Success", gravity: ToastGravity.TOP); //alert
//       print('Register Success for Email = $emailString');
//       //   setupDisplayName(); //เมื่อไรที่สมัครสมาชิกสำเร็จ ให้ call setupDisplayName ให้ทำงาน
//     }).catchError((response) {
//       print('เข้า EROR');
//       //catchError ทำต่อเมื่อ เราทำผิดกฎการสมัคร
//       // String title = response.code; //เอาresponse มาแกะ ว่าผิดอะไร
//       // String message = response.message;

//       Fluttertoast.showToast(msg: "Try again", gravity: ToastGravity.TOP);

//       // print('title = $title, message=$message');
//     });
//   }
// }

///////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////

// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';

// import 'package:fluttertoast/fluttertoast.dart';

// import 'package:New_Project_KMUTTNEWS/screens/news_view.dart';

// class RegisterTabView extends StatelessWidget {
//   final formKey = GlobalKey<FormState>();
//   String nameString, emailString, passwordString;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       //resizeToAvoidBottomPadding: false, //แก้ปัญหาขึ้น Bottom Overflowed
//       body: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 30.0),
//         child: Form(
//           key: formKey,
//           child: Container(
//             child: SingleChildScrollView(
//               child: Column(
//                 children: <Widget>[
//                   SizedBox(height: 50),
//                   nameText(),
//                   SizedBox(height: 15),
//                   emailText(),
//                   SizedBox(height: 15),
//                   passwordText(),
//                   // SizedBox(height: 15),
//                   // yearsDrop(),
//                   SizedBox(height: 5),
//                   clearButton(),
//                   SizedBox(height: 10),
//                   registerButton(context),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget nameText() {
//     return TextFormField(
//       style: TextStyle(fontSize: 12, fontFamily: 'Itim'),
//       decoration: InputDecoration(
//         enabledBorder: OutlineInputBorder(
//             borderSide: BorderSide(color: Colors.grey[200], width: 2),
//             borderRadius: BorderRadius.all(Radius.circular(10))),
//         labelText: 'Name',
//         labelStyle: TextStyle(
//           color: Colors.grey,
//         ),
//       ),
//       validator: (String value) {
//         if (value.isEmpty) {
//           return ' Please Enter Name ';
//         } else {
//           return null;
//         }
//       },
//       onSaved: (String value) {
//         nameString = value.trim();
//       },
//     );
//   }

//   Widget emailText() {
//     return TextFormField(
//       keyboardType: TextInputType.emailAddress,
//       style: TextStyle(fontSize: 12, fontFamily: 'Itim'),
//       decoration: InputDecoration(
//         enabledBorder: OutlineInputBorder(
//             borderSide: BorderSide(color: Colors.grey[200], width: 2),
//             borderRadius: BorderRadius.all(Radius.circular(10))),
//         labelText: 'Email',
//         labelStyle: TextStyle(
//           color: Colors.grey,
//         ),
//       ),
//       validator: (String value) {
//         if (!((value.contains('@')) && (value.contains('.')))) {
//           return 'Please Enter Value Email';
//         } else {
//           return null;
//         }
//       },
//       onSaved: (String value) {
//         emailString = value.trim();
//         // profile.email = emailString ;
//       },
//     );
//   }

//   Widget passwordText() {
//     return TextFormField(
//       obscureText: true, //ปิดบัง password
//       style: TextStyle(fontSize: 12, fontFamily: 'Itim'),
//       decoration: InputDecoration(
//         enabledBorder: OutlineInputBorder(
//             borderSide: BorderSide(color: Colors.grey[200], width: 2),
//             borderRadius: BorderRadius.all(Radius.circular(10))),
//         labelText: 'Password',
//         labelStyle: TextStyle(
//           color: Colors.grey,
//         ),
//       ),
//       validator: (String value) {
//         if (value.length < 6) {
//           return 'Please must be least 6 charactors';
//         } else {
//           return null;
//         }
//       },
//       onSaved: (String value) {
//         passwordString = value.trim();
//         // profile.email = passwordString ;
//       },
//     );
//   }

//   Widget clearButton() {
//     return FlatButton(
//       child: Text(
//         "Clear",
//         style: TextStyle(
//           color: Colors.grey,
//           fontSize: 11,
//           fontFamily: 'Itim',
//         ),
//       ),
//       onPressed: () {
//         formKey.currentState.reset();
//       },
//     );
//   }

//   Widget registerButton(BuildContext context) {
//     return RaisedButton(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
//       color: Colors.orange[500],
//       padding: EdgeInsets.symmetric(horizontal: 60, vertical: 10),
//       child: Text(
//         "Create new account",
//         style: TextStyle(
//             color: Colors.white,
//             fontSize: 16,
//             fontFamily: 'Itim',
//             fontWeight: FontWeight.bold),
//       ),
//       onPressed: () {
//         if (formKey.currentState.validate()) {
//           formKey.currentState.save();
//           formKey.currentState.reset();
//           //     print('name = $nameString, email =${emailString}, password = $passwordString');
//           registerThread(
//               context); //ถ้าเมื่อไรที่ได้ค่า name email pass ให้ไปทำงานที่  registerThread()
//         }
//       },
//     );
//   }

//   Future<void> registerThread(context) async {
//     // await Firebase.initializeApp();
//     print('RegisterThread');

//     //สร้าง instance ชื่อ firebaseAuth เพื่อให้มันไป call method ที่อยู่ใน plugin หรือ library มาทำงาน
//     final FirebaseAuth firebaseAuth = FirebaseAuth.instance; //firebase
//     await firebaseAuth //await คือต้องทำงานให้สำเร็จ
//         .createUserWithEmailAndPassword(
//             email: emailString, password: passwordString)
//         .then((response) {
//       //ถ้าไปสร้างใน au สำเร็จแล้วให้ return response กลับมา print...
//       Navigator.push(context, MaterialPageRoute(builder: (context) => News()));

//       Fluttertoast.showToast(
//           msg: "Register Success", gravity: ToastGravity.TOP); //alert
//       print('Register Success for Email = $emailString');
//       //   setupDisplayName(); //เมื่อไรที่สมัครสมาชิกสำเร็จ ให้ call setupDisplayName ให้ทำงาน
//     }).catchError((response) {
//       print('เข้า EROR');
//       //catchError ทำต่อเมื่อ เราทำผิดกฎการสมัคร
//       // String title = response.code; //เอาresponse มาแกะ ว่าผิดอะไร
//       // String message = response.message;

//       Fluttertoast.showToast(msg: "Try again", gravity: ToastGravity.TOP);

//       // print('title = $title, message=$message');
//     });
//   }
// }
