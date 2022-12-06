import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;
  final double btnSize;
  final Color backgroundColor;
  CustomButton(
      {required this.child,
      required this.onPressed,
      this.btnSize = 40,
      this.backgroundColor = Colors.blue});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: child,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        minimumSize: Size(double.infinity, btnSize),
      ),
    );
  }
}
