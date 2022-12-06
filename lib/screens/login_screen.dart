import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_app/screens/forget_password_screen.dart';
import 'package:instagram_clone_app/screens/main_screen.dart';

import '../constant.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_textfield.dart';
import '../widgets/or_divider.dart';
import '../widgets/spinner.dart';
import 'sign_up_screen_email.dart';

final _auth = FirebaseAuth.instance;

// ignore: unused_element
AuthError _determineError(FirebaseAuthException exception) {
  switch (exception.code) {
    case 'invalid-email':
      return AuthError.invalidEmail;
    case 'user-disabled':
      return AuthError.userDisabled;
    case 'user-not-found':
      return AuthError.userNotFound;
    case 'wrong-password':
      return AuthError.wrongPassword;
    case 'email-already-in-use':
    case 'account-exists-with-different-credential':
      return AuthError.emailAlreadyInUse;
    case 'invalid-credential':
      return AuthError.invalidCredential;
    case 'operation-not-allowed':
      return AuthError.operationNotAllowed;
    case 'weak-password':
      return AuthError.weakPassword;
    case 'ERROR_MISSING_GOOGLE_AUTH_TOKEN':
    default:
      return AuthError.error;
  }
}

enum AuthError {
  invalidEmail,
  userDisabled,
  userNotFound,
  wrongPassword,
  emailAlreadyInUse,
  invalidCredential,
  operationNotAllowed,
  weakPassword,
  error,
}

class LoginScreen extends StatefulWidget {
  static String id = 'login_screen';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;

  late String email;
  late String password;
  bool _passwordVisible = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool errorEmail = false;
  bool errorPassword = false;
  String errorMessage = '';

  login() async {
    try {
      setState(() {
        isLoading = true;
      });
      email = _emailController.text;
      password = _passwordController.text;
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      Navigator.pushReplacementNamed(context, MainScreen.id);
    } on FirebaseAuthException catch (e) {
      if (e.message! == 'Given String is empty or null') {
        setState(() {
          errorMessage = 'Please fill both the fields';
        });
      } else {
        setState(() {
          errorMessage = e.message!;
        });
      }

      var error = _determineError(e);

      if (error == AuthError.weakPassword || error == AuthError.wrongPassword) {
        setState(() {
          errorPassword = true;
        });
      } else if (error == AuthError.emailAlreadyInUse ||
          error == AuthError.invalidEmail ||
          error == AuthError.userNotFound) {
        setState(() {
          errorEmail = true;
        });
      } else {
        setState(() {
          errorEmail = true;
          errorPassword = true;
        });
      }
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.width / 3.5,
                  width: MediaQuery.of(context).size.width / 3,
                  child: Image.asset('images/instagram.png'),
                ),
                errorMessage == ''
                    ? SizedBox(
                        height: 38,
                      )
                    : SizedBox(
                        height: 38,
                        child: Text(
                          errorMessage,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                CustomTextField(
                  error: errorEmail,
                  obscureText: false,
                  controller: _emailController,
                  suffixIcon: IconButton(
                      onPressed: () {
                        _emailController.clear();
                      },
                      icon: Icon(
                        Icons.close_outlined,
                        size: 18,
                      )),
                  hintText: 'Phone number, username or email',
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  error: errorPassword,
                  controller: _passwordController,
                  obscureText: !_passwordVisible,
                  hintText: 'Password',
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                      icon: Icon(
                        _passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        size: 18,
                      )),
                ),
                SizedBox(
                  height: 8,
                ),
                Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => ForgetPassword()))),
                      child: Text(
                        'Forgot password?',
                        textAlign: TextAlign.end,
                        style: kLoginPageTextStyle,
                      ),
                    )),
                SizedBox(
                  height: 20,
                ),
                CustomButton(
                  child: isLoading
                      ? ShowSpinner()
                      : Text(
                          'Log in',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                  onPressed: () {
                    setState(() {
                      errorMessage = '';
                      errorEmail = false;
                      errorPassword = false;
                    });
                    login();
                  },
                ),
                SizedBox(
                  height: 25,
                ),
                OrDivider(),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20,
                      width: 20,
                      child: Image.asset('images/facebook-logo.png'),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Log in with Facebook',
                      style: kLoginPageTextStyle.copyWith(fontSize: 15),
                    )
                  ],
                ),
              ],
            ),
            Align(
              alignment: FractionalOffset.bottomCenter,
              child: Column(
                children: [
                  Divider(
                    color: Colors.grey,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have an account?',
                        style: kLoginPageTextStyle.copyWith(color: Colors.grey),
                      ),
                      InkWell(
                        splashColor: Colors.white,
                        onTap: () {
                          Navigator.pushNamed(context, SignUpScreenEmail.id);
                        },
                        child: Text(
                          ' Sign Up.',
                          style: kLoginPageTextStyle,
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
