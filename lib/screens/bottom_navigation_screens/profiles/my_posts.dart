import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_app/components/timeline_post_design.dart';
import 'package:instagram_clone_app/constant.dart';

class MyPost extends StatefulWidget {
  final String id;
  final bool isBookmarked;
  final bool isLiked;
  final String post_image_path;
  final String username;
  final String location;
  final String caption;
  final List comments;
  final String user_image_path;
  final int likeNumber;

  const MyPost(
      {required this.isBookmarked,
      required this.id,
      required this.isLiked,
      required this.post_image_path,
      required this.caption,
      required this.comments,
      required this.likeNumber,
      required this.location,
      required this.user_image_path,
      required this.username});

  @override
  State<MyPost> createState() => _MyPostState();
}

class _MyPostState extends State<MyPost> {
  @override
  Widget build(BuildContext context) {
    print(widget.id);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kScaffoldBackgroundColor,
        automaticallyImplyLeading: false,
        leading: InkWell(
          child: Image.asset('images/left.png'),
          onTap: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Column(
          children: [
            Text(
              widget.username.toUpperCase(),
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            Text('Posts',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('posts').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          }
          List<PostDesgin> posts = [];
          final all_posts = snapshot.data?.docs.reversed;

          for (var post in all_posts!) {
            final id = post.id;
            final String caption = post['caption'];
            final List comments = post['comments'];

            final String postImagePath = post['post_image_path'];
            final String userImagePath = post['user_image_path'];
            final String userName = post['username'];
            final int likes = post['likes'];
            final String location = post['location'];
            final newPost = PostDesgin(
              isBookmarked: post['isBookmarked'],
              isLiked: post['isLiked'],
              id: id,
              location: location,
              post_image_path: postImagePath,
              username: userName,
              caption: caption,
              comments: comments,
              user_image_path: userImagePath,
              likeNumber: likes,
            );
            if (widget.isBookmarked == true) {
              if (post['isBookmarked']) {
                posts.add(newPost);
              }
            } else {
              if (widget.id == id) {
                posts.add(newPost);
              }
            }
          }
          return ListView(
            children: posts,
          );
        },
      ),
    );
  }
}









//  return ListView(children: [
//               PostDesgin(
//                 id: widget.id,
//                 isBookmarked: widget.isBookmarked,
//                 isLiked: widget.isLiked,
//                 post_image_path: widget.post_image_path,
//                 username: widget.username,
//                 location: widget.location,
//                 caption: widget.caption,
//                 comments: widget.comments,
//                 likeNumber: widget.likeNumber,
//                 user_image_path: widget.user_image_path,
//               ),
//             ]);