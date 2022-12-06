import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  Image get plusLogo {
    return Image.asset('images/plus.png');
  }

  Image get bookmarkLogo {
    return Image.asset('images/bookmark.png');
  }

  Image get bookmarkLogoOrange {
    return Image.asset('images/bookmark_orange.png');
  }

  Image get messengerLogo {
    return Image.asset('images/messenger.png');
  }

  Image get arrowLeft {
    return Image.asset('images/left.png');
  }

  Image get commentLogoWhite {
    return Image.asset('images/instagram-comment.png');
  }

  Image get likedLogoWhite {
    return Image.asset('images/favorite_red.png');
  }

  Image get shareIconWhite {
    return Image.asset('images/share.png');
  }

  Image get notLikedWhite {
    return Image.asset('images/favourite.png');
  }

  Brightness get brightness {
    return Brightness.dark;
  }

  Color get scaffoldColor {
    return Colors.black;
  }

  void changeThemeintoLight() {}
}
