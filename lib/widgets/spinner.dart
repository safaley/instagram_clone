import 'package:flutter/material.dart';

class ShowSpinner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      SizedBox(
        child: CircularProgressIndicator(
          color: Colors.white,
          strokeWidth: 3,
        ),
        height: 20,
        width: 20,
      ),
      SizedBox(
        width: 20,
      ),
      Text(
        "PLEASE WAIT",
        style: TextStyle(fontWeight: FontWeight.bold),
      )
    ]);
  }
}
