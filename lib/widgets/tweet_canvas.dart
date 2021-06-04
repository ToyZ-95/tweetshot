import 'package:flutter/material.dart';
import 'package:tweetshot/blocs/tweet_canvas_bloc.dart';
import 'tweet_card.dart';

class TweetCanvas extends StatefulWidget {
  final String tweetLink;
  final TweetCanvasBloc tweetCanvasBloc;
  TweetCanvas({required this.tweetLink, required this.tweetCanvasBloc});

  @override
  _TweetCanvasState createState() => _TweetCanvasState(
      tweetLink: this.tweetLink, tweetCanvasBloc: tweetCanvasBloc);
}

class _TweetCanvasState extends State<TweetCanvas> {
  final String tweetLink;
  final TweetCanvasBloc tweetCanvasBloc;
  _TweetCanvasState({required this.tweetLink, required this.tweetCanvasBloc});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TweetCard(tweetLink: tweetLink, tweetCanvasBloc: tweetCanvasBloc),
    );
  }
}
