import 'package:flutter/material.dart';
import 'package:tweetshot/blocs/tweet_canvas_bloc.dart';
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

  final TweetCanvasBloc tweetCanvasBloc = TweetCanvasBloc();

  @override
  void initState() {
    try {
      tweetCanvasBloc.fetchTweet(tweetLink);
    } catch (ex) {
      tweetCanvasBloc.eventTweetSink.add(Events.Error);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                StreamBuilder<Object>(
                    stream: tweetCanvasBloc.stateCanvasStream,
                    builder: (context, snapshot) {
                      return Container(
                        color: snapshot.hasData
                            ? snapshot.data as Color
                            : Colors.lightBlueAccent,
                        padding: EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 30.0),
                        child: TweetCanvas(
                            tweetLink: tweetLink,
                            tweetCanvasBloc: tweetCanvasBloc),
                      );
                    }),
              ],
            ),
          ),
          Expanded(child: CustomizeTweet(tweetCanvasBloc: tweetCanvasBloc)),
        ],
      ),
    );
  }
}
