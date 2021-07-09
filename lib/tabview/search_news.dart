

import 'package:New_Project_KMUTTNEWS/constants.dart';
import 'package:New_Project_KMUTTNEWS/screens/news_detail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class SearchNewsTab extends StatefulWidget {
  @override
  _SearchNewsTabState createState() => _SearchNewsTabState();
}

class _SearchNewsTabState extends State<SearchNewsTab> {
  String name ="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),

        title: Card(
          child: TextField(
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.search,
                color: Colors.black.withAlpha(120), ),
              hintText: 'Search...' ,
              hintStyle: kActiveTabStyle,
              border: InputBorder.none,),
            onChanged: (val) {
              setState(() {
                name = val;
              });
            },
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: (name != "" && name != null)
            ? Firestore.instance
            .collection('News')
            .where("searchKeywords", arrayContains: name)
            .snapshots()
            : Firestore.instance.collection("News").snapshots(),
        builder: (context, snapshot) {
          return (snapshot.connectionState == ConnectionState.waiting)
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index) {
              DocumentSnapshot item = snapshot.data.documents[index];

              // return  Card(
              //   margin: EdgeInsets.symmetric(horizontal: 7, vertical: 7),
              //
              //   child: ListTile(
              //     leading: ConstrainedBox(
              //       constraints: BoxConstraints(
              //         minWidth: 44,
              //         minHeight: 44,
              //         maxWidth: 64,
              //         maxHeight: 64, ),
              //       child: Image.network(data['picture'], fit: BoxFit.cover),),
              //     title:
              //     Text(data["title"] ,
              //       style:  kTitleCard),
              //     subtitle: Text(data["detail"],
              //       style:  TextStyle(
              //         fontSize: 10.0,
              //         fontFamily: 'Itim',
              //       ),),),);
            return InkWell(
              onTap: () async{
                await FirebaseFirestore.instance
                    .collection("News")
                    .doc(item.id)
                    .update(
                  {'view_count': item['view_count'] + 1},
                );
                await Navigator.pushNamed(
                  context,
                  NewsDetail.routeName,
                  arguments: NewsDetailParams(
                      item.id,
                      item['title'],
                      item['picture']
                  ),
                  // title: Text(item['title']),
                  // subtitle: Text(item['detail']),
                );
              },
              child: Container(
                width: double.infinity,
                height: 135.0,
                margin: EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 8.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      border: Border.all(color: kGrey3, width: 1.0)),
                  child: Row(
                    children: [
                      Container(
                        width: 90.0,
                        height: 135.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          image: DecorationImage(
                            image: NetworkImage(item['picture']),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: 12.0,),
                      Expanded(
                          child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 5.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['title'],
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: kTitleCard,
                              ),
                              SizedBox(
                                height: 4.0,
                              ),
                              Text(
                                item['detail'],
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: kDetailContent,
                              ),
                            ],
                          ),))
                    ],
                  ),
                ),
              ),
            );
            },
          );
        },
      ),
    );
  }
}
