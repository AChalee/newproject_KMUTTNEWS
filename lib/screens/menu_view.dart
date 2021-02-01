import 'package:flutter/material.dart';
//import 'package:kmutt_news/screens/login_view.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:kmutt_news/constants.dart';
//import 'package:kmutt_news/widgets/category_card.dart';
// import 'package:kmutt_news/constants.dart';
// import 'package:image/image.dart';

class AddMore extends StatefulWidget {
  static const routeName = '/more';
  @override
  State<StatefulWidget> createState() {
    return _AddMoreState();
  }
}

class _AddMoreState extends State<AddMore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: new Text(
            'KMUTT NEWS',
            style: TextStyle(
                fontSize: 24,
                fontFamily: 'Prompt',
                color: Colors.white,
                fontStyle: FontStyle.italic),
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(30),
          child: GridView.count(
            crossAxisCount: 2,
            childAspectRatio: .85,
            crossAxisSpacing: 20,
            mainAxisSpacing: 40,
            children: <Widget>[
              Card(
                margin: EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => Login(),
                    //   ),
                    // );
                  },
                  splashColor: Colors.orange[500],
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ImageIcon(
                          AssetImage("assets/icons/password.png"),
                          size: 50.0,
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Text(
                          "Login",
                          style: TextStyle(fontSize: 20),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Card(
                margin: EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {},
                  splashColor: Colors.orange[500],
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ImageIcon(
                          AssetImage("assets/icons/heart.png"),
                          size: 50.0,
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Text(
                          "Save",
                          style: TextStyle(fontSize: 20),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Card(
                margin: EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {},
                  splashColor: Colors.orange[500],
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ImageIcon(
                          AssetImage("assets/icons/speaker.png"),
                          size: 50.0,
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Text(
                          "Public\nRelations",
                          style: TextStyle(fontSize: 20),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Card(
                margin: EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {},
                  splashColor: Colors.orange[500],
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ImageIcon(
                          AssetImage("assets/icons/gear.png"),
                          size: 50.0,
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Text(
                          "Setting",
                          style: TextStyle(fontSize: 20),
                        )
                      ],
                    ),
                  ),
                ),
              )
              // CategoryCard(
              //   title: "Login",
              //   imageSrc: "assets/icons/password.png",
              //   press: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //         builder: (context) => Login(),
              //       ),
              //     );
              //   },
              // ),
              // CategoryCard(
              //   title: "Save",
              //   imageSrc: "assets/icons/heart.png",
              //   press: () {},
              // ),
              // CategoryCard(
              //   title: "Public\nRelations",
              //   imageSrc: "assets/icons/speaker.png",
              //   press: () {},
              // ),
              // CategoryCard(
              //   title: "Setting",
              //   imageSrc: "assets/icons/gear.png",
              //   press: () {},
              // ),
            ],
          ),
        ));
  }
}
