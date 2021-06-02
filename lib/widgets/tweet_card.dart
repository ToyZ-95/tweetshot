import 'package:flutter/material.dart';

class TweetCard extends StatefulWidget {
  @override
  _TweetCardState createState() => _TweetCardState();
}

class _TweetCardState extends State<TweetCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 8.0,
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(),
              Column(
                children: [
                  Text('Name'),
                  SizedBox(height: 5.0),
                  Text('UserName')
                ],
              ),
            ],
          ),
          SizedBox(height: 10.0),
          Expanded(
            child: Text(
                'Tweet text Tweet text Tweet textTweet textTweet text Tweet text Tweet textTweet textTweet text Tweet text Tweet text'),
          ),
          SizedBox(height: 10.0),
          Text('Time Date'),
          SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const <Widget>[
              Icon(
                Icons.favorite,
                color: Colors.pink,
                size: 20.0,
                semanticLabel: 'Text to announce in accessibility modes',
              ),
              Text('37.4K'),
              Icon(
                Icons.repeat,
                color: Colors.green,
                size: 20.0,
              ),
              Text('37.4K'),
              Icon(
                Icons.comment,
                color: Colors.blueGrey,
                size: 20.0,
              ),
              Text('37.4K'),
            ],
          ),
          SizedBox(height: 10.0),
        ],
      ),
    );
  }
}
