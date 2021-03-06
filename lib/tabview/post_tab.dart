import 'package:New_Project_KMUTTNEWS/component/show_notification.dart';
import 'package:New_Project_KMUTTNEWS/service/add_data_service.dart';
import 'package:New_Project_KMUTTNEWS/service/logger_service.dart';
import 'package:flutter/material.dart';

class AddData extends StatefulWidget {
  @override
  _AddDataState createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  final newsTitle = TextEditingController();
  final newsContent = TextEditingController();

  String category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("๊ข่าวสารวันนี้"),
        backgroundColor: Colors.orange,
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
                          hintText: 'หัวข้อข่าวสาร',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 32.0)),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 1.0),
                              borderRadius: BorderRadius.circular(5.0))),
                    ),
                    Padding(padding: const EdgeInsets.all(10)),
                    TextFormField(
                      controller: newsContent,
                      maxLines: 7,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          hintText: 'รายละเอียด',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 32.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 1.0),
                              borderRadius: BorderRadius.circular(5.0))),
                    ),
                    Padding(padding: const EdgeInsets.all(10)),
                    RaisedButton(
                        child: Text("Post"),
                        onPressed: () {
                          if (newsTitle.text == "" || newsContent.text == "") {
                            showMessageBox(context, "ERROR",
                                "Please enter title and content before adding to firebase",
                                actions: [dismissButton(context)]);
                            logger.e("title or content can't be null");
                          } else {
                            addItem(
                                context,
                                {
                                  "title": newsTitle.text,
                                  "content": newsContent.text
                                },
                                newsTitle.text);
                            newsTitle.text = "";
                            newsContent.text = "";
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
