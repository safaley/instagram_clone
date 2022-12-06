import 'package:flutter/material.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
            child: Divider(
          color: Colors.grey,
        )),
        SizedBox(
          width: 30,
        ),
        Text(
          "OR",
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.grey.shade400),
        ),
        SizedBox(
          width: 30,
        ),
        Expanded(
            child: Divider(
          color: Colors.grey,
        )),
      ],
    );
  }
}
