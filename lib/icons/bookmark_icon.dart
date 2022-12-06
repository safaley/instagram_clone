import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/theme_provider.dart';

class BookmarkIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 30,
        width: 30,
        child: Provider.of<ThemeProvider>(context).bookmarkLogo);
  }
}
