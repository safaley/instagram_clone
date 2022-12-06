import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:instagram_clone_app/provider/story_provider.dart';
import 'package:instagram_clone_app/provider/theme_provider.dart';
import 'package:instagram_clone_app/provider/user_details_provider.dart';
import 'package:instagram_clone_app/screens/bottom_navigation_screens/bookmark_screen.dart';
import 'package:instagram_clone_app/screens/bottom_navigation_screens/chat_screen.dart';
import 'package:instagram_clone_app/screens/main_screen.dart';
import 'package:instagram_clone_app/screens/splash_screen.dart';
import 'package:provider/provider.dart';
import 'constant.dart';
import 'screens/login_screen.dart';
import 'screens/sign_up_screen_email.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MultiProvider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          brightness: Brightness.dark,
          scaffoldBackgroundColor: kScaffoldBackgroundColor,
          fontFamily: 'Roboto',
        ),
        routes: {
          LoginScreen.id: (context) => LoginScreen(),
          SplashScreen.id: (context) => SplashScreen(),
          SignUpScreenEmail.id: (context) => SignUpScreenEmail(),
          MainScreen.id: (context) => MainScreen(),
          BookmarkPage.id: (context) => BookmarkPage(),
          ChatScreen.id: (context) => ChatScreen(),
        },
        // initialRoute: LoginScreen.id,
        initialRoute: SplashScreen.id,
      ),
      providers: [
        ChangeNotifierProvider<ThemeProvider>(
          create: (_) => ThemeProvider(),
        ),
        ChangeNotifierProvider<UserProvider>(
          create: (_) => UserProvider(),
        ),
        ChangeNotifierProvider<StoryData>(
          create: (_) => StoryData(),
        ),
      ],
    );
  }
}
