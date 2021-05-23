import 'package:New_Project_KMUTTNEWS/widget/circle_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ActivitiesDatail extends StatefulWidget {
  static const routeName = "/activities/detail";
  @override
  _ActivitiesDatailState createState() => _ActivitiesDatailState();
}

class _ActivitiesDatailState extends State<ActivitiesDatail> {
  @override
  Widget build(BuildContext context) {
    final ActivitiesDatailParams params =
        ModalRoute.of(context).settings.arguments as ActivitiesDatailParams;
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
                  Spacer(),
                  CircleButton(
                    icon: Icons.share,
                    onTap: () {},
                  ),
                  CircleButton(
                    icon: Icons.favorite_border,
                    onTap: () {},
                  )
                ],
              ),
            )),
          ),
        )
        // body: StreamBuilder(
        //   stream: FirebaseFirestore.instance
        //       .collection("Activities")
        //       .doc(params.id)
        //       .snapshots(),
        //   builder: (context, snapshot) {
        //     if (snapshot.connectionState == ConnectionState.waiting) {
        //       return Center(
        //         child: Column(
        //           children: <Widget>[
        //             CircularProgressIndicator(),
        //             Text("Loading......................"),
        //           ],
        //         ),
        //       );
        //     }
        //     if (snapshot.hasData) {
        //       final item = snapshot.data;
        //       return Container(
        //         child: Column(
        //           children: [
        //             Text(item['detail']),
        //             TextFormField(initialValue: item['detail'])
        //           ],
        //         ),
        //       );
        //     }
        //     return Center(
        //       child: Column(
        //         children: <Widget>[
        //           Text("No Data..............."),
        //         ],
        //       ),
        //     );
        //   },
        // ),
        );
  }
}

class ActivitiesDatailParams {
  final String id;
  final String title;

  ActivitiesDatailParams(this.id, this.title);
}
