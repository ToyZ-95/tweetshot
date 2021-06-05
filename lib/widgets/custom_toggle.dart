import 'package:flutter/material.dart';

class CustomToggle extends StatefulWidget {
  final String text;
  final Icon icon;
  final VoidCallback onPressed;
  CustomToggle(
      {required this.text, required this.icon, required this.onPressed});

  @override
  _CustomToggleState createState() => _CustomToggleState(
      text: this.text, icon: this.icon, onPressed: this.onPressed);
}

class _CustomToggleState extends State<CustomToggle> {
  final String text;
  final Icon icon;
  final VoidCallback onPressed;
  _CustomToggleState(
      {required this.text, required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          text,
          style: TextStyle(
              color: Colors.grey[700],
              fontSize: 10.0,
              fontWeight: FontWeight.w800),
        ),
        SizedBox(
          height: 5.0,
        ),
        CircleAvatar(
          child: IconButton(icon: icon, onPressed: onPressed),
          foregroundColor: Colors.black,
          backgroundColor: Colors.lightBlue[300],
          radius: 32.0,
        ),
      ],
    );
  }
}
