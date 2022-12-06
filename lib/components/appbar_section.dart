import 'package:flutter/material.dart';
import 'package:instagram_clone_app/services/photo_uploader.dart';
import 'package:instagram_clone_app/constant.dart';
import 'package:instagram_clone_app/screens/bottom_navigation_screens/chat_screen.dart';
import 'package:provider/provider.dart';
import '../provider/theme_provider.dart';
import '../screens/bottom_navigation_screens/bookmark_screen.dart';

class AppBarSection extends StatefulWidget {
  @override
  State<AppBarSection> createState() => _AppBarSectionState();
}

class _AppBarSectionState extends State<AppBarSection> {
  PhotoUploader photoUploader = PhotoUploader();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: kScaffoldBackgroundColor,
      title: SizedBox(
        height: 120,
        width: 120,
        child: appBarLogo,
      ),
      actions: [
        InkWell(
          onTap: () {
            showModalBottomSheet(
              context: context,
              builder: ((builder) => photoUploader.bottomSheet(context)),
            );
          },
          child: SizedBox(
              height: 30,
              width: 30,
              child: Provider.of<ThemeProvider>(context).plusLogo),
        ),
        SizedBox(
          width: 20,
        ),
        InkWell(
          onTap: () {
            Navigator.pushNamed(context, BookmarkPage.id);
          },
          child: SizedBox(
              height: 30,
              width: 30,
              child: Provider.of<ThemeProvider>(context).bookmarkLogo),
        ),
        SizedBox(
          width: 20,
        ),
        InkWell(
          onTap: () {
            Navigator.pushNamed(context, ChatScreen.id);
          },
          child: SizedBox(
              height: 30,
              width: 30,
              child: Provider.of<ThemeProvider>(context).messengerLogo),
        ),
        SizedBox(
          width: 20,
        ),
      ],
    );
  }
}
