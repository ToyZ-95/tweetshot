import 'dart:async';
import 'package:tweetshot/models/tweet.dart';
import 'package:tweetshot/services/twitter_api.dart';

enum Events { Fetching, Fecthed, Error }

class TweetCanvasBloc {
  late Tweet tweet;

  final _eventTweetStreamController = StreamController<Events>();
  StreamSink<Events> get eventTweetSink => _eventTweetStreamController.sink;
  Stream<Events> get eventTweetStream => _eventTweetStreamController.stream;

  final _stateTweetStreamController = StreamController<Object>();
  StreamSink<Object> get stateTweetSink => _stateTweetStreamController.sink;
  Stream<Object> get stateTweetStream => _stateTweetStreamController.stream;

  TweetCanvasBloc() {
    eventTweetStream.listen((event) {
      if (event == Events.Fetching) {
        stateTweetSink.add('Fetching');
      } else if (event == Events.Fecthed) {
        stateTweetSink.add(tweet);
      } else if (event == Events.Error) {
        stateTweetSink.add('Please provide valid link!!!');
      }
    });
  }

  void fetchTweet(String tweetLink) async {
    eventTweetSink.add(Events.Fetching);

    TwitterApi twitterApi = TwitterApi(
        'AAAAAAAAAAAAAAAAAAAAACUIQQEAAAAAoDwXBPzLBsxP3y5kCiHm2nZOtxM%3DfLUeE1fI1JDnLZaqOF3pm2FYu1vNLzqXUJc66v9dGPjzNDIgxh');

    String id = Uri.parse(tweetLink).pathSegments.last;

    tweet = await twitterApi.getTweet(id);

    eventTweetSink.add(Events.Fecthed);
  }

  void dispose() {
    _eventTweetStreamController.close();
    _stateTweetStreamController.close();
  }
}
