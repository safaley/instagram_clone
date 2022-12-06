import 'package:flutter/material.dart';

class PostModal {
  Widget userImage;
  String userName;
  String postImage;
  String? caption;
  int commentNumber;
  int likeNumber;
  bool isLiked;
  bool isBookmarked;

  PostModal(
      {this.caption,
      this.isBookmarked = false,
      this.isLiked = false,
      required this.commentNumber,
      required this.likeNumber,
      required this.postImage,
      required this.userImage,
      required this.userName});
}
