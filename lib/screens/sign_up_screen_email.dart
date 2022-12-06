import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone_app/constant.dart';
import 'package:instagram_clone_app/screens/main_screen.dart';
import 'package:instagram_clone_app/widgets/custom_button.dart';
import 'package:instagram_clone_app/widgets/custom_textfield.dart';
import 'package:instagram_clone_app/widgets/or_divider.dart';

import '../widgets/spinner.dart';

class SignUpScreenEmail extends StatefulWidget {
  static String id = 'sign_up_screen_email';

  @override
  State<SignUpScreenEmail> createState() => _SignUpScreenEmailState();
}

class _SignUpScreenEmailState extends State<SignUpScreenEmail> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late String email;

  late String password;
  final imagePicker = ImagePicker();
  String imageUrl = '';
  bool isLoading = false;

  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

  sign_up() async {
    try {
      setState(() {
        isLoading = true;
      });
      email = _emailController.text;
      password = _passwordController.text;
      if (email != '' && password != '') {
        await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        final uid = _auth.currentUser?.uid;
        _firestore.collection('users').doc(uid).set({
          "username": _usernameController.text,
          "fullName": capitalize(_fullNameController.text),
          "email": _emailController.text,
          "user_image_path": imageUrl,
          "followers": 0,
          "following": 0
        });
        setState(() {
          isLoading = false;
        });

        Navigator.pushNamedAndRemoveUntil(
            context, MainScreen.id, (Route<dynamic> route) => false);
      }
    } catch (e) {
      print(e);
    }
  }

  Widget myAvatar(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: Alignment(1.1, 1.2),
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
            Builder(
              builder: (context) => CircleAvatar(
                radius: 18,
                backgroundColor: kScaffoldBackgroundColor,
                child: IconButton(
                  icon: Icon(Icons.add_circle),
                  color: Colors.blue,
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        builder: ((builder) => bottomSheet(context)));
                  },
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget bottomSheet(BuildContext context) {
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
  }

  String error = '';

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _fullNameController.dispose();
    _usernameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(),
              Text(
                'Enter Details',
                style: kSignUpPageTextStyle,
              ),
              myAvatar(context),
              error == ''
                  ? SizedBox()
                  : Text(
                      error,
                      style: TextStyle(color: Colors.red),
                    ),
              Column(
                children: [
                  CustomTextField(
                    controller: _fullNameController,
                    hintText: 'Full Name',
                    obscureText: false,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                    controller: _emailController,
                    hintText: 'Email address',
                    obscureText: false,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                    controller: _usernameController,
                    hintText: 'Username',
                    obscureText: false,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                    controller: _passwordController,
                    hintText: 'Password',
                    obscureText: true,
                  ),
                ],
              ),
              CustomButton(
                  child: isLoading
                      ? ShowSpinner()
                      : Text(
                          'Sign Up and Log in',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                  onPressed: () async {
                    setState(() {
                      error = '';
                    });
                    if (_fullNameController.text == '' ||
                        _emailController.text == '' ||
                        _usernameController.text == '' ||
                        _passwordController.text == '') {
                      setState(() {
                        error = 'Fields must not be empty';
                      });
                    } else {
                      sign_up();
                    }
                  }),
              Column(
                children: [
                  OrDivider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account?',
                        style: kLoginPageTextStyle.copyWith(color: Colors.grey),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      InkWell(
                        splashColor: Colors.white,
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          ' Sign In.',
                          style: kLoginPageTextStyle,
                        ),
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
