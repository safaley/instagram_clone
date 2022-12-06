import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../screens/bottom_navigation_screens/new_post_screen.dart';

class PhotoUploader {
  final imagePicker = ImagePicker();
  String imageUrl = '';

  Future uploadImage(source) async {
    final _firebaseStorage = FirebaseStorage.instance;
    final _imagePicker = ImagePicker();
    final image = await _imagePicker.pickImage(source: source);
    print('image path ${image!.path}');

    var file = File(image.path);
    String imageName = image.name;

    var snapshot =
        await _firebaseStorage.ref().child('images/$imageName').putFile(file);

    var downloadUrl = await snapshot.ref.getDownloadURL();

    imageUrl = downloadUrl;

    print(imageUrl);
  }

  Widget bottomSheet(BuildContext context) {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            "Choose photo",
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            TextButton.icon(
              icon: Icon(Icons.camera),
              onPressed: () async {
                try {
                  await uploadImage(ImageSource.camera);
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) =>
                              NewPostScreen(image_path: imageUrl))));
                } catch (e) {
                  print(e);
                }
              },
              label: Text("Camera"),
            ),
            SizedBox(
              width: 10,
            ),
            TextButton.icon(
              icon: Icon(Icons.image),
              onPressed: () async {
                try {
                  await uploadImage(ImageSource.gallery);
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) =>
                              NewPostScreen(image_path: imageUrl))));
                } catch (e) {
                  print(e);
                }
              },
              label: Text("Gallery"),
            ),
          ])
        ],
      ),
    );
  }
}
