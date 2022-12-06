import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../constant.dart';
import '../icons/bookmark_icon.dart';
import '../icons/comment_icon.dart';
import '../icons/like_icon.dart';
import '../icons/share_icon.dart';
import '../icons/unbookmark_icon.dart';
import '../icons/unlike_icon.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
User? user = auth.currentUser;
final uid = user?.uid;
final _firestore = FirebaseFirestore.instance;

// ignore: must_be_immutable
class PostDesgin extends StatefulWidget {
  final String post_image_path;
  final String username;
  final String? user_image_path;
  final int likeNumber;
  final bool isLiked;
  final bool isBookmarked;
  final String caption;
  final String location;
  final List? comments;
  final id;

  PostDesgin(
      {required this.id,
      required this.isBookmarked,
      required this.isLiked,
      required this.post_image_path,
      required this.username,
      this.location = '',
      this.comments,
      this.caption = '',
      this.likeNumber = 0,
      this.user_image_path});

  @override
  State<PostDesgin> createState() => _PostDesginState();
}

class _PostDesginState extends State<PostDesgin> {
  bool showBookmark = false;
  var isLiked;
  var isBookmarked;
  String email = '';
  String fullName = '';
  String imageUrl = '';
  String userName = '';

  getUserDetails() {
    final uid = auth.currentUser?.uid;
    DocumentReference docRef = _firestore.collection('users').doc(uid);
    docRef.get().then((DocumentSnapshot doc) {
      if (mounted) {
        setState(() {
          userName = doc['username'];
          email = doc['email'];
          fullName = doc['fullName'];
          imageUrl = doc['user_image_path'];
        });
      }
    });
  }

  Future getLike() async {
    var value = await FirebaseFirestore.instance
        .collection('posts')
        .doc(widget.id)
        .get()
        .then((value) {
      return value.data()!['isLiked'];
    });
    return value;
  }

  Future getBookmark() async {
    var value = await FirebaseFirestore.instance
        .collection('posts')
        .doc(widget.id)
        .get()
        .then((value) {
      return value.data()!['isBookmarked'];
    });
    return value;
  }

  Future getLikeNumber() async {
    var value = await FirebaseFirestore.instance
        .collection('posts')
        .doc(widget.id)
        .get()
        .then((value) {
      return value.data()!['likes'];
    });
    return value;
  }

  @override
  void initState() {
    super.initState();
    getUserDetails();
  }

  showDeleteAlertDialog(
      {required BuildContext context,
      required onPressed,
      required title,
      required content}) {
    // set up the button
    Widget okButton = ElevatedButton(
      child: Text("OK"),
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
    );

    Widget cancelButton = ElevatedButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
      style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
    );

    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [okButton, cancelButton],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  addComment() async {
    DocumentReference docRef =
        FirebaseFirestore.instance.collection('posts').doc(widget.id);
    if (_commentController.text != '') {
      setState(() {
        docRef.update(
          {
            "comments": FieldValue.arrayUnion(
              [
                {
                  "comment": _commentController.text,
                  "name": user == null ? "safaley" : userName,
                  "created_at": DateTime.now()
                }
              ],
            )
          },
        );
      });

      _commentController.clear();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _commentController.dispose();
  }

  final TextEditingController _commentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                CircleAvatar(
                  radius: 14.0,
                  child: ClipRRect(
                    child: widget.user_image_path != null
                        ? Image.network(widget.user_image_path!)
                        : Image.asset('images/user/user.jpeg'),
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.username.split('@')[0],
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    widget.location != ''
                        ? Padding(
                            padding: const EdgeInsets.only(top: 2),
                            child: Text(
                              widget.location,
                              style: TextStyle(fontSize: 13),
                            ),
                          )
                        : SizedBox()
                  ],
                )
              ],
            ),
            IconButton(
                onPressed: () async {
                  DocumentReference docRef = await FirebaseFirestore.instance
                      .collection('posts')
                      .doc(widget.id);
                  if (user?.email == email) {
                    showDeleteAlertDialog(
                        context: context,
                        onPressed: () async {
                          docRef.delete();
                          Navigator.pop(context);
                        },
                        title: 'Delete',
                        content: 'Are you sure want to delete this post?');
                  }
                },
                icon: Icon(
                  Icons.more_horiz,
                ))
          ],
        ),
        Hero(
          tag: '${widget.id}',
          child: Container(
            padding: EdgeInsets.only(left: 2, right: 2),
            height: MediaQuery.of(context).size.width,
            width: MediaQuery.of(context).size.width,
            child: Image.network(
              widget.post_image_path,
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                InkWell(
                    onTap: () async {
                      DocumentReference docRef = FirebaseFirestore.instance
                          .collection('posts')
                          .doc(widget.id);
                      isLiked = await getLike();
                      var likes = await getLikeNumber();
                      setState(() {
                        docRef.update({"isLiked": !isLiked});
                      });

                      isLiked != true
                          ? docRef.update({"likes": likes + 1})
                          : docRef.update({"likes": likes - 1});
                    },
                    child: widget.isLiked != true ? UnlikeIcon() : LikeIcon()),
                SizedBox(
                  width: 20,
                ),
                CommentIcon(),
                SizedBox(
                  width: 20,
                ),
                ShareIcon()
              ],
            ),
            Row(
              children: [
                InkWell(
                    onTap: () async {
                      DocumentReference docRef = FirebaseFirestore.instance
                          .collection('posts')
                          .doc(widget.id);
                      isBookmarked = await getBookmark();
                      print(isBookmarked);
                      setState(() {
                        docRef.update({"isBookmarked": !isBookmarked});
                      });

                      !isBookmarked
                          ? showAddedBookmarkSnackBar(context)
                          : showRemovedBookmarkSnackBar(context);
                    },
                    child: widget.isBookmarked != true
                        ? BookmarkIcon()
                        : UnBookmarkIcon()),
                SizedBox(
                  width: 10,
                )
              ],
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: widget.likeNumber != 0
              ? Row(
                  children: [
                    CircleAvatar(
                      radius: 9.0,
                      child: ClipRRect(
                        child: widget.user_image_path == null
                            ? Image.asset('images/user/user.jpeg')
                            : Image.network(widget.user_image_path!),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                              text: '${widget.likeNumber}',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(
                            text: ' likes',
                          )
                        ],
                        style: DefaultTextStyle.of(context).style,
                      ),
                    )
                  ],
                )
              : SizedBox(),
        ),
        SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              Text(widget.username.split('@')[0],
                  style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(
                width: 5,
              ),
              Text(widget.caption)
            ],
          ),
        ),
        widget.comments?.length != 0
            ? Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Text(
                  'View all comments',
                  style: TextStyle(color: Colors.grey),
                ),
              )
            : Container(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: ListView.builder(
            padding: EdgeInsets.zero,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: widget.comments?.length,
            itemBuilder: (context, index) {
              return Container(
                height: 20,
                child: Row(
                  children: [
                    Text(widget.comments![index]['name'],
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(
                      width: 5,
                    ),
                    Text(widget.comments![index]['comment']),
                  ],
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Row(
            children: [
              CircleAvatar(
                radius: 14,
                child: ClipRRect(
                  child: Image.network(widget.user_image_path!),
                  borderRadius: BorderRadius.circular(50.0),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Flexible(
                child: TextField(
                  controller: _commentController,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                      suffixIcon: IconButton(
                        icon: Icon(
                          Icons.arrow_upward_outlined,
                          color: Colors.white,
                        ),
                        onPressed: () async {
                          addComment();
                        },
                      ),
                      hintStyle: TextStyle(fontSize: 14),
                      hintText: 'Add a comment...'),
                ),
              )
            ],
          ),
        ),
        Divider(
          color: Colors.grey,
        )
      ],
    );
  }
}
