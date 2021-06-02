import 'package:flutter/material.dart';
import 'tweet_card.dart';

class TweetCanvas extends StatefulWidget {
  @override
  _TweetCanvasState createState() => _TweetCanvasState();
}

class _TweetCanvasState extends State<TweetCanvas> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 60.0),
      child: (Container(
        padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 110.0),
        color: Colors.blueAccent,
        child: TweetCard(),
      )),
    );
  }
}
