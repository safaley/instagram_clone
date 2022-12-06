import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_app/constant.dart';
import 'package:instagram_clone_app/screens/bottom_navigation_screens/profiles/profile_page.dart';
import 'package:instagram_clone_app/screens/main_screen.dart';

class EditProfileScreen extends StatefulWidget {
  final String name;
  final String username;
  const EditProfileScreen({required this.name, required this.username});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.name;
    _usernameController.text = widget.username;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kScaffoldBackgroundColor,
        title: Text(
          'Edit profile',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: TextButton(
          child: Text(
            'Cancel',
            style: TextStyle(fontSize: 13, color: Colors.white),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          TextButton(
            onPressed: () {
              var _auth = FirebaseAuth.instance;
              var uid = _auth.currentUser?.uid;
              DocumentReference docRef =
                  FirebaseFirestore.instance.collection('users').doc(uid);
              docRef.update({
                'fullName': _nameController.text,
                'username': _usernameController.text
              });
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: ((context) {
                    return MainScreen(
                      ind: 2,
                    );
                  }),
                ),
              );
            },
            child: Text(
              'Done',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 4,
                  child: Text(
                    'Name',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
                Flexible(
                  child: TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      fillColor: Color(0xFF1B1B1B),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 4,
                  child: Text(
                    'Username',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
                Flexible(
                  child: TextField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      fillColor: Color(0xFF1B1B1B),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
