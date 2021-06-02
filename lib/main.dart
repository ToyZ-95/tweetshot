import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tweetshot/pages/homepage.dart';

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
