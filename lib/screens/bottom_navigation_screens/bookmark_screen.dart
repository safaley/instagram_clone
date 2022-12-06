import 'package:flutter/material.dart';
import 'package:instagram_clone_app/components/appbar_section.dart';
import 'package:instagram_clone_app/components/post_stream.dart';
import 'package:instagram_clone_app/constant.dart';

class BookmarkPage extends StatefulWidget {
  static String id = 'bookmark_screen';
  const BookmarkPage({super.key});

  @override
  State<BookmarkPage> createState() => _TimelinePageState();
}

class _TimelinePageState extends State<BookmarkPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kScaffoldBackgroundColor,
        title: Text(
          'Bookmarks',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            PostsStream(
              isBookmarked: true,
            ),
          ],
        ),
      ),
    );
  }
}
