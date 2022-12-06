import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String? hintText;
  final TextEditingController controller;
  final IconButton? suffixIcon;
  final bool obscureText;
  final bool error;
  CustomTextField(
      {this.error = false,
      this.hintText,
      required this.controller,
      this.suffixIcon,
      this.obscureText = false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          hintText: hintText,
          hintStyle: TextStyle(fontSize: 13),
          filled: true,
          fillColor: Color(0xFF1B1B1B),
          enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(width: 0, color: error ? Colors.red : Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(width: 0, color: error ? Colors.red : Colors.grey),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
