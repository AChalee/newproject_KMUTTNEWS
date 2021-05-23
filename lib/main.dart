import 'package:New_Project_KMUTTNEWS/launcher.dart';
import 'package:New_Project_KMUTTNEWS/screens/activities_detail.dart';
//import 'package:New_Project_KMUTTNEWS/screens/activities_view.dart';
import 'package:New_Project_KMUTTNEWS/screens/news_detail.dart';
import 'package:New_Project_KMUTTNEWS/tabview/edit_news.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.orange,
        textTheme: TextTheme(bodyText1: TextStyle(color: Colors.orange)),
      ),
      title: 'Flutter App',
      initialRoute: '/', //สามารถใช้ home แทนได้
      routes: {
        Launcher.routeName: (context) => Launcher(),
        NewsDetail.routeName: (context) => NewsDetail(),
        ActivitiesDatail.routeName: (context) => ActivitiesDatail(),
        EditNews.routeName: (context) => EditNews(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  get json => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
