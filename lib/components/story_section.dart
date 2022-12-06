import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_app/services/story_builder.dart';
import 'package:instagram_clone_app/constant.dart';
import 'package:instagram_clone_app/data.dart';
import 'package:instagram_clone_app/modals/story.dart';
import 'package:instagram_clone_app/provider/story_provider.dart';
import 'package:provider/provider.dart';

final _auth = FirebaseAuth.instance;
final _firestore = FirebaseFirestore.instance;

class StorySection extends StatefulWidget {
  @override
  State<StorySection> createState() => _StorySectionState();
}

class _StorySectionState extends State<StorySection> {
  Color backgroundColor = Color.fromARGB(255, 243, 33, 100);

  List<StoryModal> getStories(context) {
    List<StoryModal> _stories = [
      StoryModal(
          userName: 'You',
          image: imageUrl != ''
              ? Image.network(imageUrl)
              : Image.asset('images/user/insta_blank.jpeg')),
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
    return _stories;
  }

  Widget avtar(int index, BuildContext context) {
    List<StoryModal> stories = getStories(context);
    return Column(
      children: [
        CircleAvatar(
            radius: 35.0,
            backgroundColor:
                stories[index].isViewed ? Colors.grey : backgroundColor,
            child: CircleAvatar(
              radius: 33,
              backgroundColor: kScaffoldBackgroundColor,
              child: Container(
                height: 62,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(50))),
                child: ClipRRect(
                  child: stories[index].image,
                  borderRadius: BorderRadius.circular(50.0),
                ),
              ),
            )),
      ],
    );
  }

  String email = '';
  String fullName = '';
  String imageUrl = '';

  getUserDetails() async {
    final uid = await _auth.currentUser?.uid;
    DocumentReference docRef = await _firestore.collection('users').doc(uid);
    var snapshot = await docRef.get();
    setState(() {
      email = snapshot.get('email');
      fullName = snapshot.get('fullName');
      imageUrl = snapshot.get('user_image_path');
    });
  }

  @override
  void initState() {
    super.initState();
    getUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    List<StoryModal> stories = getStories(context);
    return SizedBox(
        height: 100,
        width: double.infinity,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: stories.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                child: InkWell(
                  onTap: () {
                    Provider.of<StoryData>(context, listen: false)
                        .toggleIsViewed(index);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: ((context) =>
                            StoryBuilder(stories: storiess[index])),
                      ),
                    );
                  },
                  child: SizedBox(
                    child: Column(
                      children: [
                        avtar(index, context),
                        SizedBox(
                          height: 3,
                        ),
                        Text(
                          stories[index].userName,
                          style: TextStyle(fontSize: 12),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }));
  }
}
