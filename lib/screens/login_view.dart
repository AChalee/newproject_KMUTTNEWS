import 'package:New_Project_KMUTTNEWS/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:New_Project_KMUTTNEWS/tabview/login_tab_view.dart';
import 'package:New_Project_KMUTTNEWS/tabview/register_tab_view.dart';

class Login extends StatelessWidget {
  static const routeName = '/login';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomPadding: false, //Keyboard ก็จะไม่มาดัน Content ให้เกิดการ Bottom Overflowed Flutter Keyboard
      // ส่วนบน KMUTT News
      body: Container(
        padding: EdgeInsets.only(top: 10),
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, colors: [
          Colors.orange[900],
          Colors.orange[800],
          Colors.orange[400]
        ])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment
              .center, // การจัดในแกนขวาง  ขนาดไม่เท่ากัน ก็ได้

          children: <Widget>[
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(26),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'KMUTT NEWS',
                    style: TextStyle(
                        fontSize: 24,
                        fontFamily: 'Prompt',
                        color: Colors.white,
                        fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold),

                  ),
                ],
              ),
            ),
            SizedBox(
              height: 1, //ระยะช่วงโค้งถึง KMUTT NEWS
            ),
            Expanded(
                child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(45),
                  topRight: Radius.circular(45),
                ),
              ),
              child: DefaultTabController(
                  length: 2,
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 15, //ขอบขาว ถึงตัวหนังสือ
                        ),
                        Container(
                          constraints: BoxConstraints.expand(height: 50),
                          child: TabBar(
                              indicatorWeight: 3, //ความหนาของเส้นขีดเส้นใต้
                              indicatorColor: Colors.orange,
                              labelColor: Colors.orange,
                              unselectedLabelColor: Colors.grey,
                              tabs: [
                                Tab(
                                    child: Text('Log in ',
                                        style: kTitleCard)),
                                Tab(
                                    child: Text('Register',
                                        style: kTitleCard)),
                              ]),
                        ),
                        Expanded(
                            child: Container(
                          child: TabBarView(children: <Widget>[
                            LoginTabView(),
                            RegisterTabView(),
                          ]),
                        ))
                      ],
                    ),
                  )),
            ))
          ],
        ),
      ),
    );
  }
}
