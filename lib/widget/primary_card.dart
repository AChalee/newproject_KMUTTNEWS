import 'package:New_Project_KMUTTNEWS/models/news.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
//import 'package:kmutt_news/models/news.dart';
//import 'package:kmutt_news/constants.dart';

import '../constants.dart';

class PrimaryCard extends StatelessWidget {
  final News news;
  PrimaryCard({this.news});

  //get index => null;

  @override
  Widget build(BuildContext context) {
    //var snapshot;
    return Container(
      width: 300.0,
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(color: kGrey3, width: 1.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 5.0,
                backgroundColor: kGrey1,
              ),
              SizedBox(width: 10.0),
              Text(
                news.category,
                style: kCategoryTitle,
              )
            ],
          ),
          SizedBox(height: 5.0),
          Expanded(
            child: Hero(
              tag: news.seen,
              child: Container(
                // -----------------------------------เรียกรูปภาพมาแสดง----------------------------------------------
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    image: NetworkImage(news.image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 5.0),
          // ------------------------เรียก title--------------------------
          //Text(snapshot.data.documents[index].documentID),
          Text(
            news.title,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: kTitleCard,
          ),
          SizedBox(height: 5.0),
          Row(
            children: [
              Text(
                news.time,
                style: kDetailContent,
              ),
              SizedBox(width: 10.0),
              CircleAvatar(
                radius: 5.0,
                backgroundColor: kGrey1,
              ),
              SizedBox(
                width: 10.0,
              ),
              Text(
                "${news.estimate} min read",
                style: kDetailContent,
              )
            ],
          )
        ],
      ),
    );
  }
}
