// import 'package:New_Project_KMUTTNEWS/constants.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';

// class AddActivities extends StatefulWidget {
//   @override
//   _AddActivitiesState createState() => _AddActivitiesState();
// }

// class _AddActivitiesState extends State<AddActivities> {
//   String imageUrl;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Upload Image'),
//       ),
//       body: Column(
//         children: <Widget>[
//           (imageUrl != null)
//               ? Image.network(imageUrl)
//               : Placeholder(
//                   fallbackHeight: 200.0,
//                   fallbackWidth: double.infinity,
//                 ),
//           SizedBox(
//             height: 20.0,
//           ),
//           RaisedButton(
//             child: Text("Upload Image"),
//             color: Colors.lightBlue,
//             onPressed: () => uploadImage(),
//           )
//         ],
//       ),
//     );
//   }

//   uploadImage() async {
//     final _storage = FirebaseStorage.instance;
//     final _picker = ImagePicker();

//     final image = await _picker.getImage(source: ImageSource.gallery);
//     File file = File(image.path);

//     DateTime now = new DateTime.now();
//     var snapshot = await _storage
//         .ref()
//         .child('image/${now.toString()}')
//         .putFile(file)
//         .onComplete;
//   }
// }
import 'package:New_Project_KMUTTNEWS/constants.dart';
import 'package:flutter/material.dart';

class AddActivities extends StatefulWidget {
  @override
  _AddActivitiesState createState() => _AddActivitiesState();
}

class _AddActivitiesState extends State<AddActivities> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'กิจกรรมวันนี้',
          style: kTitleCard,
        ),
      ),
    );
  }
}
