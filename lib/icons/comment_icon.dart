import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constant.dart';
import '../provider/theme_provider.dart';

class CommentIcon extends StatelessWidget {
  const CommentIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      width: 30,
      child: Provider.of<ThemeProvider>(context).commentLogoWhite,
    );
  }
}
