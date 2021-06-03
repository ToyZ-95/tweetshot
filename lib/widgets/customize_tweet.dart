import 'package:flutter/material.dart';

class CustomizeTweet extends StatefulWidget {
  @override
  _CustomizeTweetState createState() => _CustomizeTweetState();
}

class _CustomizeTweetState extends State<CustomizeTweet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.0,
      decoration: BoxDecoration(color: Colors.amber),
      child: Center(child: Text('This is for customize tweet')),
    );
  }
}
