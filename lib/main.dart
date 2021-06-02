import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tweetshot/services/twitter_api.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TweetShot',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final twitterApi = TwitterApi(
      'AAAAAAAAAAAAAAAAAAAAACUIQQEAAAAAoDwXBPzLBsxP3y5kCiHm2nZOtxM%3DfLUeE1fI1JDnLZaqOF3pm2FYu1vNLzqXUJc66v9dGPjzNDIgxh');
  @override
  void initState() {
    twitterApi.getTweet('1399849500638916616');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(),
    );
  }
}
