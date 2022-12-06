import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_app/services/location.dart';

import '../../constant.dart';

final _firestore = FirebaseFirestore.instance;
User? loggedInUser;
final _auth = FirebaseAuth.instance;

class NewPostScreen extends StatefulWidget {
  static String id = 'new_post_screen';
  final String image_path;
  NewPostScreen({required this.image_path});

  @override
  State<NewPostScreen> createState() => _NewPostScreenState();
}

class _NewPostScreenState extends State<NewPostScreen> {
  String imageUrl = '';
  String userName = '';
  String email = '';
  String fullName = '';
  String countryName = '';
  String cityName = '';
  String loc = '';
  bool isLoading = false;
  final TextEditingController _captionController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _captionController.dispose();
  }

  getUserDetails() async {
    final uid = await _auth.currentUser?.uid;
    DocumentReference docRef = await _firestore.collection('users').doc(uid);
    var snapshot = await docRef.get();
    if (mounted) {
      setState(() {
        userName = snapshot.get('username');
        email = snapshot.get('email');
        fullName = snapshot.get('fullName');
        imageUrl = snapshot.get('user_image_path');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    getUserDetails();
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: Image.asset('images/left.png')),
        title: Text('New Post'),
        centerTitle: false,
        backgroundColor: kScaffoldBackgroundColor,
        actions: [
          TextButton(
              onPressed: () async {
                await _firestore.collection('posts').add({
                  'username': userName,
                  'email': email,
                  'caption': _captionController.text,
                  'created_at': DateTime.now(),
                  'likes': 0,
                  'isBookmarked': false,
                  'isLiked': false,
                  'comments': [],
                  'post_image_path': widget.image_path,
                  'user_image_path': imageUrl,
                  'location': loc != '' ? '$loc' : ''
                });
                Navigator.pop(context);
              },
              child: Text(
                'Share',
                style: TextStyle(fontSize: 16),
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  height: 80,
                  width: 60,
                  child: ClipRRect(
                    child: Image.network(widget.image_path),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 11),
                    child: TextField(
                      controller: _captionController,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Write a caption...'),
                      maxLines: 4,
                    ),
                  ),
                )
              ],
            ),
            InkWell(
              onTap: () async {
                setState(() {
                  isLoading = true;
                });
                Location location = Location();
                await location.getCurrentLocation();
                setState(() {
                  countryName = location.cityName!;
                  cityName = location.countryName!;
                  loc = '$countryName, $cityName';
                  isLoading = false;
                });
              },
              child: Container(
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Add Location',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        isLoading
                            ? SizedBox(
                                child: CircularProgressIndicator(
                                    color: Colors.white),
                                width: 12,
                                height: 12,
                              )
                            : Text(loc),
                        SizedBox(width: 10),
                        Icon(Icons.arrow_right_outlined),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
