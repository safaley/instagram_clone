import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_app/screens/login_screen.dart';
import 'package:instagram_clone_app/widgets/custom_button.dart';
import 'package:instagram_clone_app/widgets/custom_textfield.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final _auth = FirebaseAuth.instance;
  // FirebaseUser user = await FirebaseAuth.instance.currentUser();
  final TextEditingController _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 100,
                  width: 100,
                  child: Image.asset('images/lock.png'),
                ),
                SizedBox(
                  height: 40,
                ),
                Text(
                  'Trouble logging in?',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Enter your email and we\'ll send you a link to get back to your account',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                ),
                SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  controller: _emailController,
                  obscureText: false,
                  hintText: 'Enter your email',
                ),
                SizedBox(
                  height: 10,
                ),
                CustomButton(
                    child: Text('Next'),
                    onPressed: () async {
                      try {
                        await _auth.sendPasswordResetEmail(
                            email: _emailController.text);

                        showDialog(
                            context: context,
                            builder: ((context) {
                              return AlertDialog(
                                actions: [
                                  ElevatedButton(
                                      onPressed: () {
                                        Navigator.pushNamedAndRemoveUntil(
                                            context,
                                            LoginScreen.id,
                                            (route) => false);
                                      },
                                      child: Text('Ok'))
                                ],
                                title: Text('Sent'),
                                content: Text(
                                    'Reset link sent successfully !\nPlease check your email and click ok to redirect to login screen'),
                              );
                            }));
                      } catch (e) {
                        print(e);
                      }
                    }),
              ],
            ),
            Column(
              children: [
                Divider(
                  color: Colors.grey,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Back to log in',
                    style: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
