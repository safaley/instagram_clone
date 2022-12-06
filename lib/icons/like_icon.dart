import 'package:flutter/material.dart';
import 'package:instagram_clone_app/constant.dart';
import 'package:instagram_clone_app/provider/theme_provider.dart';
import 'package:provider/provider.dart';

class LikeIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 30,
        width: 30,
        child: Provider.of<ThemeProvider>(context).likedLogoWhite);
  }
}
