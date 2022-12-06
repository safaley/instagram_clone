import 'dart:collection';
import 'package:flutter/material.dart';
import '../modals/story.dart';

class StoryData extends ChangeNotifier {
  List<StoryModal> _stories = [
    StoryModal(
        userName: 'You',
        image: Image.network(
            'https://firebasestorage.googleapis.com/v0/b/instagram-clone-1f7fa.appspot.com/o/images%2Fimage_picker8848706555322964184.jpg?alt=media&token=a2c664a3-246d-49dc-b46a-1f22ea6c8db6')),
    StoryModal(
      userName: 'milan.p',
      image: Image.asset('images/user/milan.jpg'),
    ),
    StoryModal(
      userName: 'safaley',
      image: Image.asset('images/user/safal.jpg'),
    ),
    StoryModal(
      userName: 'nir.adh',
      image: Image.asset('images/user/niranjan.jpg'),
    ),
    StoryModal(
      userName: 'nsaroj',
      image: Image.asset('images/user/saroj.jpg'),
    ),
    StoryModal(
      userName: 'p.astp',
      image: Image.asset('images/user/milan.jpg'),
    ),
  ];

  UnmodifiableListView<StoryModal> get stories {
    return UnmodifiableListView(_stories);
  }

  int get storyCount {
    return _stories.length;
  }

  void addPost(StoryModal newStory) {
    _stories.add(newStory);
    notifyListeners();
  }

  void replaceMyPhoto(Widget image) {
    _stories[0] = StoryModal(userName: 'You', image: image);
    notifyListeners();
  }

  void toggleIsViewed(index) {
    _stories[index].isViewed = true;
    notifyListeners();
  }

  void removeStory(StoryModal story) {
    _stories.remove(story);
    notifyListeners();
  }
}
