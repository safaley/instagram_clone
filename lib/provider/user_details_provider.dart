import 'package:flutter/cupertino.dart';

class UserProvider extends ChangeNotifier {
  String _user_image_path =
      'https://firebasestorage.googleapis.com/v0/b/instagram-clone-1f7fa.appspot.com/o/images%2Fimage_picker8848706555322964184.jpg?alt=media&token=a2c664a3-246d-49dc-b46a-1f22ea6c8db6';

  String _fullName = 'user';
  String _username = 'username';
  String _email = 'user@gmail.com';
  int _followers = 0;
  int _following = 0;
  // '/data/user/0/com.example.instagram_clone_app/cache/5ce57ba2-40c7-479f-8e63-008ac82647ed637439969170995920.jpg';

  String get user_image_path {
    return _user_image_path;
  }

  String get fullName {
    return _fullName;
  }

  String get username {
    return _username;
  }

  String get email {
    return _email;
  }

  int get followers {
    return _followers;
  }

  int get following {
    return _following;
  }

  changeDisplayPic(image_path) {
    _user_image_path = image_path;
    notifyListeners();
  }

  newEmail(input) {
    _email = input;
    notifyListeners();
  }

  newUsername(input) {
    _username = input;
    notifyListeners();
  }

  newFullName(input) {
    _fullName = input;
    notifyListeners();
  }

  newFollowers(input) {
    _followers = input;
    notifyListeners();
  }

  newFollowing(input) {
    _following = input;
    notifyListeners();
  }
}
