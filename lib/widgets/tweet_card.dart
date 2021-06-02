import 'package:flutter/material.dart';
import 'package:tweetshot/blocs/tweet_canvas_bloc.dart';
import 'package:tweetshot/models/tweet.dart';

class TweetCard extends StatefulWidget {
  final String tweetLink;

  TweetCard({required this.tweetLink});

  @override
  _TweetCardState createState() => _TweetCardState(tweetLink: this.tweetLink);
}

class _TweetCardState extends State<TweetCard> {
  final TweetCanvasBloc tweetCanvasBloc = TweetCanvasBloc();
  final String tweetLink;

  _TweetCardState({required this.tweetLink});

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
    return Card(
      color: Colors.white,
      elevation: 8.0,
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: StreamBuilder<Object>(
          stream: tweetCanvasBloc.stateTweetStream,
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data is Tweet) {
              Tweet tweet = snapshot.data as Tweet;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                            tweet.includes.users[0].profileImageUrl),
                      ),
                      SizedBox(width: 5.0),
                      Column(
                        children: [
                          Text(
                            tweet.includes.users[0].name,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '@' + tweet.includes.users[0].username,
                            style: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    tweet.data[0].text,
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    tweet.data[0].createdAt.toString(),
                    style: TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey),
                  ),
                  SizedBox(height: 10.0),
                  Expanded(
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.favorite,
                          color: Colors.pink,
                          size: 20.0,
                          semanticLabel:
                              'Text to announce in accessibility modes',
                        ),
                        SizedBox(width: 5.0),
                        Text(
                          tweet.data[0].publicMetrics.likeCount.toString(),
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey),
                        ),
                        SizedBox(width: 24.0),
                        Icon(
                          Icons.repeat,
                          color: Colors.green,
                          size: 20.0,
                        ),
                        Text(
                          tweet.data[0].publicMetrics.retweetCount.toString(),
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey),
                        ),
                        SizedBox(width: 24.0),
                        Icon(
                          Icons.mode_comment_outlined,
                          color: Colors.blueGrey,
                          size: 20.0,
                        ),
                        Text(
                          tweet.data[0].publicMetrics.replyCount.toString(),
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else if (snapshot.hasData &&
                snapshot.data.toString() == 'Fetching') {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Center(child: Text(snapshot.data.toString()));
            }

            // else {
            //   return Center(
            //     child: CircularProgressIndicator(),
            //   );
            // }
          },
        ),
      ),
    );
  }
}
