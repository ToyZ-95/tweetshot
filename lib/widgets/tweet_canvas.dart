import 'package:flutter/material.dart';

class TweetCanvas extends StatefulWidget {
  @override
  _TweetCanvasState createState() => _TweetCanvasState();
}

class _TweetCanvasState extends State<TweetCanvas> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 60.0),
      child: Container(
        color: Colors.blueAccent,
      ),
    );
  }
}
