import 'package:flutter/material.dart';
import 'package:instagram_clone_app/components/appbar_section.dart';
import 'package:instagram_clone_app/components/post_stream.dart';
import '../../components/story_section.dart';
import 'chat_screen.dart';

class TimelinePage extends StatefulWidget {
  const TimelinePage({super.key});

  @override
  State<TimelinePage> createState() => _TimelinePageState();
}

class _TimelinePageState extends State<TimelinePage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        int sensitivity = 8;
        if (details.delta.dx > sensitivity) {
        } else if (details.delta.dx < -sensitivity) {
          Navigator.pushNamed(context, ChatScreen.id);
        }
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBarSection(),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              StorySection(),
              PostsStream(),
            ],
          ),
        ),
      ),
    );
  }
}
