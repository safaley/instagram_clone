import 'package:flutter/material.dart';
import 'package:instagram_clone_app/screens/bottom_navigation_screens/profiles/my_posts.dart';

class ProfilePost extends StatelessWidget {
  final String post_image_path;
  final String username;
  final String user_image_path;
  final int likeNumber;
  final bool isLiked;
  final bool isBookmarked;
  final String caption;
  final String location;
  final List comments;
  final id;

  ProfilePost(
      {required this.id,
      this.isBookmarked = false,
      this.isLiked = false,
      required this.post_image_path,
      required this.username,
      this.location = '',
      required this.comments,
      this.caption = '',
      this.likeNumber = 0,
      required this.user_image_path});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: ((context) {
          return MyPost(
              isBookmarked: isBookmarked,
              id: id,
              isLiked: isLiked,
              post_image_path: post_image_path,
              caption: caption,
              comments: comments,
              likeNumber: likeNumber,
              location: location,
              user_image_path: user_image_path,
              username: username);
        })));
      },
      child: Hero(
        tag: '${id}',
        child: Container(
          margin: EdgeInsets.all(3),
          height: 100,
          width: 100,
          color: Colors.white,
          child: Image.network(post_image_path),
        ),
      ),
    );
  }
}
