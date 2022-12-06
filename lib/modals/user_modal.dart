import 'package:flutter/material.dart';
import 'package:instagram_clone_app/modals/story_modal.dart';

class User {
  final String name;
  final Widget profileImageUrl;
  final List<Story> stories;

  const User(
      {required this.name,
      required this.profileImageUrl,
      required this.stories});
}
