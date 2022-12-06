import 'package:flutter/material.dart';

const kLoginPageTextStyle =
    TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 12);

const kSignUpPageTextStyle =
    TextStyle(fontWeight: FontWeight.bold, fontSize: 25);

const kScaffoldBackgroundColor = Colors.black;

const kSendButtonTextStyle = TextStyle(
  color: Colors.lightBlueAccent,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kMessageTextFieldDecoration = InputDecoration(
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(50)),
      borderSide: BorderSide(width: 0, color: Colors.grey),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(50)),
      borderSide: BorderSide(width: 0, color: Colors.grey),
    ),
    contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
    hintText: 'Message...',
    suffixIconColor: Colors.blue,
    suffixIcon: Icon(Icons.abc_rounded));

showAddedBookmarkSnackBar(context) {
  const snackBar = SnackBar(
    content: Text('Added to Bookmarks'),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

showRemovedBookmarkSnackBar(context) {
  const snackBar = SnackBar(
    content: Text('Removed from Bookmarks'),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

Image appBarLogo = Image.asset(
  'images/instagram.png',
);
