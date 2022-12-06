import 'package:flutter/material.dart';

class ImageData extends ChangeNotifier {
  String _user_image_path =
      'https://firebasestorage.googleapis.com/v0/b/instagram-clone-1f7fa.appspot.com/o/images%2Fimage_picker8848706555322964184.jpg?alt=media&token=a2c664a3-246d-49dc-b46a-1f22ea6c8db6';
  // '/data/user/0/com.example.instagram_clone_app/cache/5ce57ba2-40c7-479f-8e63-008ac82647ed637439969170995920.jpg';

  String get user_image_path {
    return _user_image_path;
  }

  void changeDisplayPic(image_path) {
    _user_image_path = image_path;
    notifyListeners();
  }
}
