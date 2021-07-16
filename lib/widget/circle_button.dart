//import 'package:kmutt_news/constants.dart';
import 'package:New_Project_KMUTTNEWS/constants.dart';
import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  final IconData icon;
  final Function onTap;
  final Color color;
  CircleButton({this.icon, this.onTap,this.color = Colors.white});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(25.0),
      child: Container(
        width: 50.0,
        height: 50.0,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
        child: Card(
          color: color,
          elevation: 1.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          child: Icon(
            icon,
            color: kGrey2,
            size: 15.0,
          ),
        ),
      ),
    );
  }
}
