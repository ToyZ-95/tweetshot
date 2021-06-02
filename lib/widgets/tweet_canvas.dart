import 'package:flutter/material.dart';
import 'tweet_card.dart';

class TweetCanvas extends StatefulWidget {
  final String tweetLink;

  TweetCanvas({required this.tweetLink});

  @override
  _TweetCanvasState createState() =>
      _TweetCanvasState(tweetLink: this.tweetLink);
}

class _TweetCanvasState extends State<TweetCanvas> {
  final String tweetLink;

  _TweetCanvasState({required this.tweetLink});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 60.0),
      child: (Container(
        padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 80.0),
        color: Colors.blueAccent,
        child: TweetCard(tweetLink: tweetLink),
      )),
    );
  }
}
