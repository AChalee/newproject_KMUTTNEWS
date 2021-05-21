import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddActItem extends StatelessWidget {
  final String actTitile;
  final String actDetail;

  AddActItem(this.actTitile, this.actDetail);

  @override
  Widget build(BuildContext context) {
    CollectionReference item =
        FirebaseFirestore.instance.collection('Activities');

    Future<void> addItem() {
      return item
          .add({
            'title': actTitile,
            'detail': actDetail,
          })
          .then((value) => print("Item Added"))
          .catchError((error) => print('Failed to add user:$error'));
    }

    return RaisedButton(
      onPressed: addItem,
      child: Text("Add item"),
    );
  }
}
