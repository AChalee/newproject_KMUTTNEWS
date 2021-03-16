import 'package:New_Project_KMUTTNEWS/component/show_notification.dart';
import 'package:New_Project_KMUTTNEWS/service/logger_service.dart';
import 'package:flutter/material.dart';

class AddNews extends StatefulWidget {
  @override
  _AddNewsState createState() => _AddNewsState();
}

class _AddNewsState extends State<AddNews> {
  final newsTitle = TextEditingController();
  final newsContent = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "ข่าวสารวันนี้",
          style: TextStyle(
              color: Colors.white, fontFamily: 'Prompt', fontSize: 24),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    Padding(padding: const EdgeInsets.all(10)),
                    TextFormField(
                      controller: newsTitle,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          hintText: "หัวข้อข่าวสาร",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 32.0)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 1.0))),
                    ),
                    Padding(padding: const EdgeInsets.all(10)),
                    TextFormField(
                      controller: newsContent,
                      maxLines: 7,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          hintText: "รายละเอียด",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 1.0))),
                    ),
                    Padding(padding: const EdgeInsets.all(10)),
                    RaisedButton(
                        child: Text("โพสต์"),
                        onPressed: () {
                          if (newsTitle.text == "" || newsContent.text == "") {
                            showMessageBox(
                                context, "ผิดพลาด", "กรุณากรอกรายละเอียด",
                                actions: [dismissButton(context)]);
                                logger.e("message")
                          }
                        })
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
