import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tweetshot/models/tweet.dart';
import 'package:tweetshot/services/twitter_api.dart';

enum Events {
  Fetching,
  Fecthed,
  Error,
  BackgroundChanged,
  ShowLikes,
  ShowRetweets,
  ShowComments,
  ShowDate,
}

class TweetCanvasBloc {
  late Tweet tweet;
  Color canvasColor = Colors.blueAccent;

  Map<Events, bool> tweetData = Map<Events, bool>();

  final _eventTweetStreamController = StreamController<Events>.broadcast();
  StreamSink<Events> get eventTweetSink => _eventTweetStreamController.sink;
  Stream<Events> get eventTweetStream => _eventTweetStreamController.stream;

  final _stateTweetStreamController = StreamController<Object>.broadcast();
  StreamSink<Object> get stateTweetSink => _stateTweetStreamController.sink;
  Stream<Object> get stateTweetStream => _stateTweetStreamController.stream;

  final _eventCanvasController = StreamController<Events>.broadcast();
  StreamSink<Events> get eventCanvasSink => _eventCanvasController.sink;
  Stream<Events> get eventCanvasStream => _eventCanvasController.stream;

  final _stateCanvasController = StreamController<Object>.broadcast();
  StreamSink<Object> get stateCanvasSink => _stateCanvasController.sink;
  Stream<Object> get stateCanvasStream => _stateCanvasController.stream;

  final _eventCustomToggleController = StreamController<Events>.broadcast();
  StreamSink<Events> get eventCustomToggleSink =>
      _eventCustomToggleController.sink;
  Stream<Events> get eventCustomToggleStream =>
      _eventCustomToggleController.stream;

  final _stateCustomToggleController =
      StreamController<Map<Events, bool>>.broadcast();
  StreamSink<Map<Events, bool>> get stateCustomToggleSink =>
      _stateCustomToggleController.sink;
  Stream<Map<Events, bool>> get stateCustomToggleStream =>
      _stateCustomToggleController.stream;

  TweetCanvasBloc() {
    tweetData[Events.ShowLikes] = true;
    tweetData[Events.ShowRetweets] = true;
    tweetData[Events.ShowComments] = true;
    tweetData[Events.ShowDate] = true;
    eventTweetStream.listen((event) {
      if (event == Events.Fetching) {
        stateTweetSink.add('Fetching');
      } else if (event == Events.Fecthed) {
        stateTweetSink.add(tweet);
      } else if (event == Events.Error) {
        stateTweetSink.add('Please provide valid link!!!');
      }
    });

    eventCanvasStream.listen((event) {
      if (event == Events.BackgroundChanged) {
        stateCanvasSink.add(canvasColor);
      }
    });

    eventCustomToggleStream.listen((event) {
      if (event == Events.ShowLikes) {
        tweetData[Events.ShowLikes] =
            tweetData[Events.ShowLikes] == true ? false : true;
      } else if (event == Events.ShowRetweets) {
        tweetData[Events.ShowRetweets] =
            tweetData[Events.ShowRetweets] == true ? false : true;
      } else if (event == Events.ShowComments) {
        tweetData[Events.ShowComments] =
            tweetData[Events.ShowComments] == true ? false : true;
      } else if (event == Events.ShowDate) {
        tweetData[Events.ShowDate] =
            tweetData[Events.ShowDate] == true ? false : true;
      }
      stateCustomToggleSink.add(tweetData);
    });
  }

  void fetchTweet(String tweetLink) async {
    eventTweetSink.add(Events.Fetching);

    TwitterApi twitterApi = TwitterApi(
        'AAAAAAAAAAAAAAAAAAAAACUIQQEAAAAAoDwXBPzLBsxP3y5kCiHm2nZOtxM%3DfLUeE1fI1JDnLZaqOF3pm2FYu1vNLzqXUJc66v9dGPjzNDIgxh');

    String id = Uri.parse(tweetLink).pathSegments.last;

    try {
      tweet = await twitterApi.getTweet(id);
      eventTweetSink.add(Events.Fecthed);
    } catch (ex) {
      eventTweetSink.add(Events.Error);
    }
  }

  void setCanvasColor(Color color) {
    canvasColor = color;
    eventCanvasSink.add(Events.BackgroundChanged);
  }

  void dispose() {
    _eventTweetStreamController.close();
    _stateTweetStreamController.close();
    _eventCanvasController.close();
    _stateCanvasController.close();
    _eventCustomToggleController.close();
    _stateCustomToggleController.close();
  }
}
