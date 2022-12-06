import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone_app/components/profile_post_design.dart';
import 'package:instagram_clone_app/constant.dart';
import 'package:instagram_clone_app/screens/bottom_navigation_screens/profiles/edit_profile.dart';
import 'package:instagram_clone_app/screens/login_screen.dart';
import 'package:instagram_clone_app/services/photo_uploader.dart';
import 'package:instagram_clone_app/widgets/custom_button.dart';

final _auth = FirebaseAuth.instance;
final _firestore = FirebaseFirestore.instance;

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final imagePicker = ImagePicker();
  String imageUrl = '';
  String userName = '';
  String email = '';
  String fullName = '';
  int followers = 0;
  int following = 0;
  int postLen = 0;

  PhotoUploader photoUploader = PhotoUploader();
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  uploadImage(source) async {
    final _firebaseStorage = FirebaseStorage.instance;
    final _imagePicker = ImagePicker();
    final image = await _imagePicker.pickImage(source: source);
    var file = File(image!.path);
    String imageName = image.path.split('/').last;
    var snapshot =
        await _firebaseStorage.ref().child('images/$imageName').putFile(file);

    var downloadUrl = await snapshot.ref.getDownloadURL();
    setState(() {
      imageUrl = downloadUrl;
    });
    print(imageUrl);
    final uid = await _auth.currentUser?.uid;
    DocumentReference docRef = await _firestore.collection('users').doc(uid);
    docRef.update({"user_image_path": imageUrl});
  }

  Widget bottomSheet({required BuildContext context}) {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            "Choose photo",
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            TextButton.icon(
              icon: Icon(Icons.camera),
              onPressed: () {
                uploadImage(ImageSource.camera);
                Navigator.pop(context);
              },
              label: Text("Camera"),
            ),
            SizedBox(
              width: 10,
            ),
            TextButton.icon(
              icon: Icon(Icons.image),
              onPressed: () {
                uploadImage(ImageSource.gallery);
                Navigator.pop(context);
              },
              label: Text("Gallery"),
            ),
          ])
        ],
      ),
    );
  }

  getUserDetails() async {
    var postSnap = await FirebaseFirestore.instance
        .collection('posts')
        .where("email", isEqualTo: _auth.currentUser!.email)
        .get();
    setState(() {
      postLen = postSnap.docs.length;
      docRef.doc(uid).get().then((DocumentSnapshot doc) {
        setState(() {
          userName = doc['username'];
          email = doc['email'];
          fullName = doc['fullName'];
          imageUrl = doc['user_image_path'];
          followers = doc['followers'];
          following = doc['following'];
        });
      });
    });
    print('postlen $postLen');
  }

  Widget myAvatar(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: Alignment(1, 1),
          children: [
            CircleAvatar(
              radius: 50.0,
              child: ClipRRect(
                child: imageUrl == ''
                    ? Image.asset('images/user/insta_blank.jpeg')
                    : Image.network(imageUrl),
                borderRadius: BorderRadius.circular(50.0),
              ),
            ),
            CircleAvatar(
              radius: 13,
              backgroundColor: kScaffoldBackgroundColor,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(11),
                child: InkWell(
                  onTap: () {
                    showBottomSheet(
                        context: context,
                        builder: ((builder) => bottomSheet(context: context)));
                  },
                  child: Icon(
                    Icons.add_circle,
                    color: Colors.blue,
                  ),
                ),
              ),
            )
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Text(
            fullName,
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
        )
      ],
    );
  }

  final uid = _auth.currentUser?.uid;
  var docRef = _firestore.collection('users');

  @override
  void initState() {
    getUserDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _key,
        endDrawer: Drawer(
          backgroundColor: kScaffoldBackgroundColor,
          child: ListView(
            padding: EdgeInsets.only(top: 20),
            children: [
              ListTile(
                leading: Icon(
                  Icons.arrow_left,
                ),
                title: const Text('Log out'),
                onTap: () {
                  _auth.signOut();
                  Navigator.pushNamedAndRemoveUntil(
                      context, LoginScreen.id, (route) => false);
                },
              ),
            ],
          ),
        ),
        appBar: AppBar(
          backgroundColor: kScaffoldBackgroundColor,
          title: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Icon(
                  Icons.lock_outline,
                  size: 15,
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Text(userName.contains('@') ? userName.split('@')[0] : userName),
              SizedBox(
                width: 5,
              ),
            ],
          ),
          actions: [
            InkWell(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: ((builder) => photoUploader.bottomSheet(context)),
                );
              },
              child: Icon(
                Icons.add_box_outlined,
                size: 29,
              ),
            ),
            SizedBox(
              width: 20,
            ),
            IconButton(
              icon: (Icon(Icons.menu, size: 29)),
              onPressed: () {
                _key.currentState!.openEndDrawer();
              },
            ),
            SizedBox(
              width: 20,
            ),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      myAvatar(context),
                      Row(
                        children: [
                          Column(
                            children: [Text('$postLen'), Text('Posts')],
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Column(
                            children: [Text('${followers}'), Text('Followers')],
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Column(
                            children: [Text('${following}'), Text('Following')],
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomButton(
                      backgroundColor: Colors.grey.shade700,
                      btnSize: 30,
                      child: Text(
                        'Edit Profile',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: ((context) => EditProfileScreen(
                                  name: fullName,
                                  username: userName,
                                )),
                          ),
                        );
                      })
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            StreamBuilder<QuerySnapshot>(
              stream: _firestore
                  .collection('posts')
                  .orderBy('created_at', descending: false)
                  .snapshots(),
              builder: (context, snapshot) {
                List<ProfilePost> posts = [];
                if (!snapshot.hasData) {
                  return Center(
                      child: CircularProgressIndicator(
                    backgroundColor: Colors.white,
                  ));
                } else {
                  final all_posts = snapshot.data?.docs.reversed;

                  for (var post in all_posts!) {
                    final id = post.id;
                    final String caption = post['caption'];
                    final List comments = post['comments'];
                    final String email = post['email'];
                    final String postImagePath = post['post_image_path'];
                    final String userImagePath = post['user_image_path'];
                    final String userName = post['username'];
                    final int likes = post['likes'];
                    final String location = post['location'];

                    if (email == _auth.currentUser!.email) {
                      final newPost = ProfilePost(
                          id: id,
                          post_image_path: postImagePath,
                          caption: caption,
                          comments: comments,
                          likeNumber: likes,
                          location: location,
                          user_image_path: userImagePath,
                          username: userName);
                      posts.add(newPost);
                    }
                  }
                }

                return Flexible(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 0,
                      mainAxisSpacing: 0,
                      crossAxisCount: 3,
                    ),
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      return ProfilePost(
                          id: posts[index].id,
                          post_image_path: posts[index].post_image_path,
                          caption: posts[index].caption,
                          comments: posts[index].comments,
                          likeNumber: posts[index].likeNumber,
                          location: posts[index].location,
                          user_image_path: posts[index].user_image_path,
                          username: userName);
                    },
                  ),
                );
              },
            )
          ],
        ));
  }
}
