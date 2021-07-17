import 'package:New_Project_KMUTTNEWS/screens/news_detail.dart';
import 'package:New_Project_KMUTTNEWS/service/add_news_service.dart';
import 'package:New_Project_KMUTTNEWS/widget/circle_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class EditNews extends StatefulWidget {
  static final routeName = "/news/edit";

  @override
  _EditNewsState createState() => _EditNewsState();
}

class _EditNewsState extends State<EditNews> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController titleController;
  TextEditingController detailController;
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final NewsEditParams params =
          ModalRoute.of(context).settings.arguments as NewsEditParams;
      titleController = TextEditingController(text: params.title);
      detailController = TextEditingController(text: params.detail);
    });
  }

  @override
  Widget build(BuildContext context) {
    final NewsEditParams params =
        ModalRoute.of(context).settings.arguments as NewsEditParams;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(65.0),
        child: Center(
          child: SafeArea(
              child: Padding(
            padding: EdgeInsets.fromLTRB(18.0, 15.0, 18.0, 0),
            child: Row(
              children: [
                CircleButton(
                  icon: Icons.arrow_back_ios,
                  onTap: () => Navigator.pop(context),
                ),
              ],
            ),
          )),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("News")
            .doc(params.id)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Column(
                children: <Widget>[
                  CircularProgressIndicator(),
                  Text("Loading........."),
                ],
              ),
            );
          }
          if (snapshot.hasData) {
            final item = snapshot.data;
            return Form(
              key: _formKey,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 18.0),
                child: ListView(
                  children: [
                    SizedBox(
                      height: 12.0,
                    ),
                    Container(
                      height: 220.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        image: DecorationImage(
                            image: NetworkImage(item['picture']),
                            fit: BoxFit.fill),
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Text(
                      "หัวข้อ",
                      style: kTitleCard.copyWith(fontSize: 20.0),
                    ),
                    TextFormField(
                      controller: titleController,
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Text(
                      "รายละเอียด",
                      style: descriptionStyle,
                    ),
                    TextFormField(
                      controller: detailController,
                    ),
                    MaterialButton(
                      onPressed: () async {
                        await FirebaseFirestore.instance
                            .collection("News")
                            .doc(item.id)
                            .update(
                          {
                            'title': titleController.text,
                            'detail': detailController.text
                          },
                        );
                        Navigator.pop(context);
                      },

                      child: Text('บันทึก'),
                      color: kGrey3,
                    ),
                  ],
                ),
              ),
            );
          }
          if (snapshot.hasError) {
            logger.e("Fetch news error : ${snapshot.error.toString()}");
            return Center(
              child: Column(
                children: <Widget>[
                  Text("Error Something........."),
                ],
              ),
            );
          }
          return Center(
            child: Column(
              children: <Widget>[
                Text("No Data........."),
              ],
            ),
          );
        },
      ),
    );
  }
}
// }

class NewsEditParams {
  final String id; //กดมาจากหน้า latestNews
  final String title;
  final String detail;

  NewsEditParams(this.id, this.title, this.detail);
}
