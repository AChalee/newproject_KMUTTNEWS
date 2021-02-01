import 'package:New_Project_KMUTTNEWS/screens/activities_view.dart';
import 'package:New_Project_KMUTTNEWS/screens/menu_view.dart';
import 'package:New_Project_KMUTTNEWS/screens/news_view.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
//import 'package:kmutt_news/screens/activities_view.dart';

// import 'package:kmutt_news/screens/activies.dart';

// import 'package:kmutt_news/screens/menu_view.dart';
// import 'package:kmutt_news/screens/menu_view_user_login.dart';
// import 'package:kmutt_news/screens/news_view.dart';

// import 'models/viewdata_news.dart';

class Launcher extends StatefulWidget {
  static const routeName = '/';

  @override
  State<StatefulWidget> createState() {
    return _LauncherState();
  }
}

class _LauncherState extends State<Launcher> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  int _selectedIndex = 0;
  List<Widget> _pageWidget = <Widget>[News(), Activities(), AddMore()];
  List<BottomNavigationBarItem> _menuBar = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(Icons.description),
      title: Text(
        'ข่าว',
        style: TextStyle(fontSize: 14, fontFamily: 'Prompt'),
      ),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.event_available),
      title: Text(
        'กิจกรรม',
        style: TextStyle(fontSize: 14, fontFamily: 'Prompt'),
      ),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.menu),
      title: Text(
        'อื่นๆ',
        style: TextStyle(fontSize: 14, fontFamily: 'Prompt'),
      ),
    ),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
// @override
// void initState() {
// super.initState();
// _loadViewData();
//   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageWidget.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: _menuBar,
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.black38,
        onTap: _onItemTapped,
      ),
    );
  }
}

// Future _loadViewData() async {
//   String data = await DefaultAssetBundle.of(context)
//       .loadString("assets/json/newsdata.json");
//   final parsed = json.decode(data).cast<Map<String, dynamic>>();

//   final jsonResult = parsed
//       .map<ViewData>((json) => ViewData.fromJson(json))
//       .toList();

//   print(jsonResult[0].id);
//   print(jsonResult[0].title);
//   print(jsonResult[0].detail);
//   print("-------------------------------------------------------------------------------------");
//   print(jsonResult[1].id);
//   print(jsonResult[1].title);
//   print(jsonResult[1].detail);
//   print("-------------------------------------------------------------------------------------");
//   print(jsonResult[2].id);
//   print(jsonResult[2].title);
//   print(jsonResult[2].detail);
//   print("-------------------------------------------------------------------------------------");
//   return parsed;
// }
