import 'package:New_Project_KMUTTNEWS/models/news.dart';
import 'package:New_Project_KMUTTNEWS/tabview/read_news_view.dart';
import 'package:New_Project_KMUTTNEWS/widget/primary_card.dart';
import 'package:flutter/material.dart';
//import 'package:kmutt_news/models/news.dart';
//import 'package:kmutt_news/views/read_news_view.dart';
//import 'package:kmutt_news/widgets/primary_card.dart';

class TrendingActTabView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: trendingList.length,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        var trending = trendingList[index];

        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ReadNewsView(
                  news: trending,
                ),
              ),
            );
          },
          child: Container(
            width: double.infinity,
            height: 300.0,
            margin: EdgeInsets.symmetric(horizontal: 18.0, vertical: 12),
            child: PrimaryCard(
              news: trending,
            ),
          ),
        );
      },
    );
  }
}
