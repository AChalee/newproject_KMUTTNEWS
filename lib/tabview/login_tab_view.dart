import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:google_sign_in/google_sign_in.dart';
import 'package:New_Project_KMUTTNEWS/tabview/register_tab_view.dart';

// import 'package:New_Project_KMUTTNEWS/firebase/sign_in.dart';
// import 'package:New_Project_KMUTTNEWS/screens/FirstScreen.dart';

class LoginTabView extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // final GoogleSignIn googleSignIn = GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(30),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 20,
          ),

          Container(
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                        color: Colors.grey[200], // set border color
                        width: 2), // set border width
                    borderRadius: BorderRadius.all(
                        Radius.circular(15)), // set rounded corner radius
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                        hintText: "Email",
                        hintStyle: TextStyle(
                            fontSize: 12,
                            fontFamily: 'Itim',
                            color: Colors.grey),
                        border: InputBorder.none),
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                        color: Colors.grey[200], // set border color
                        width: 2), // set border width
                    borderRadius: BorderRadius.all(
                        Radius.circular(15)), // set rounded corner radius
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Password ",
                      hintStyle: TextStyle(
                          fontSize: 12, fontFamily: 'Itim', color: Colors.grey),
                      border: InputBorder.none,
                    ),

                    //  textAlign: TextAlign.center
                  ),
                ),
              ],
            ),
          ),

          SizedBox(
            height: 5,
          ), //ห่างจากช่องกรอก
          Text(
            "Forgot Password?",
            style: TextStyle(
              fontSize: 12,
              fontFamily: 'Itim',
              color: Colors.grey,
            ),
          ),

          SizedBox(
            height: 15,
          ), //ห่างจาก forget password

          Container(
            height: 45,
            margin: EdgeInsets.symmetric(horizontal: 55),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.orange[500],
            ),
            child: Center(
              child: Text(
                "LOGIN",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontFamily: 'Itim',
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),

          SizedBox(
            height: 15,
          ), //ห่างจากช่องกรอก
          Text(
            "Continue with social media",
            style: TextStyle(
              fontSize: 12,
              fontFamily: 'Itim',
              color: Colors.grey,
            ),
          ),

///////////////////////////////
          SizedBox(height: 15),
          //   _signInGoogle(),
///////////////////////////////
        ],
      ),
    );
  }

  // Widget _signInGoogle() {
  //   return OutlineButton(
  //     onPressed: () {
  //       signInWithGoogle().then((result) {
  //         if (result != null) {
  //           Navigator.of(context).push(
  //             MaterialPageRoute(
  //               builder: (context) {
  //                 print("จุ้บๆจุกกรุ้ ++++++++++++++++++++++++++++++")
  //            //     return FirstScreen();
  //               },
  //             ),
  //           );
  //         }
  //       });
  //     },
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.circular(50),
  //     ),

  //     // highlightElevation: 0,
  //     // borderSide: BorderSide(color: Colors.grey),

  //     child: Padding(
  //       padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
  //       child: Row(
  //         mainAxisSize: MainAxisSize.min,
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: <Widget>[
  //           //  Image(image: AssetImage("assets/google_logo.png"), height: 35.0),
  //           Padding(
  //             padding: const EdgeInsets.only(left: 10),
  //             child: Text(
  //               'Sign in with Google',
  //               style: TextStyle(
  //                 fontSize: 12,
  //                 fontFamily: 'Itim',
  //                 color: Colors.grey,
  //               ),
  //             ),
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
