import 'package:flutter/material.dart';
import 'package:tweetshot/widgets/customize_tweet.dart';
import 'package:tweetshot/widgets/tweet_canvas.dart';

class TweetModificationPage extends StatefulWidget {
  final String tweetLink;

  TweetModificationPage({required this.tweetLink});

  @override
  _TweetModificationPageState createState() =>
      _TweetModificationPageState(tweetLink: this.tweetLink);
}

class _TweetModificationPageState extends State<TweetModificationPage> {
  final String tweetLink;

  _TweetModificationPageState({required this.tweetLink});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TweetCanvas(tweetLink: tweetLink),
          CustomizeTweet(),
        ],
      ),
    );
  }
}
