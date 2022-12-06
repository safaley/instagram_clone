import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_app/components/timeline_post_design.dart';

User? loggedInUser;
final _auth = FirebaseAuth.instance;
final _firestore = FirebaseFirestore.instance;

class PostsStream extends StatefulWidget {
  final bool? isBookmarked;
  PostsStream({this.isBookmarked = false});
  @override
  State<PostsStream> createState() => _PostsStreamState();
}

class _PostsStreamState extends State<PostsStream> {
  String email = '';
  String fullName = '';
  String imageUrl = '';
  String userName = '';

  getUserDetails() {
    final uid = _auth.currentUser?.uid;
    DocumentReference docRef = _firestore.collection('users').doc(uid);
    docRef.get().then((DocumentSnapshot doc) {
      setState(() {
        userName = doc['username'];
        email = doc['email'];
        fullName = doc['fullName'];
        imageUrl = doc['user_image_path'];
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection('posts')
          .orderBy('created_at', descending: false)
          .snapshots(),
      builder: (context, snapshot) {
        List<PostDesgin> posts = [];
        if (!snapshot.hasData) {
          return Center(
              child: CircularProgressIndicator(
            color: Colors.white,
          ));
        } else {
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
              posts.add(newPost);
            }
          }
        }

        return Flexible(
          child: ListView(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: posts.length == 0
                ? [
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height / 2.5),
                      child: Center(
                        child: Text(
                          'No Bookmarked Posts',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ]
                : posts,
          ),
        );
      },
    );
  }
}
