import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tweetshot/blocs/tweet_canvas_bloc.dart';
import 'package:tweetshot/models/tweet.dart';

class TweetCard extends StatefulWidget {
  final String tweetLink;
  final TweetCanvasBloc tweetCanvasBloc;
  TweetCard({required this.tweetLink, required this.tweetCanvasBloc});

  @override
  _TweetCardState createState() => _TweetCardState(
      tweetLink: this.tweetLink, tweetCanvasBloc: tweetCanvasBloc);
}

class _TweetCardState extends State<TweetCard> {
  final TweetCanvasBloc tweetCanvasBloc;
  final String tweetLink;

  _TweetCardState({required this.tweetLink, required this.tweetCanvasBloc});

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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                tweet.includes.users[0].name,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                width: 3.0,
                              ),
                              if (tweet.includes.users[0].verified)
                                Image.asset(
                                  'assets/verified.png',
                                  scale: 180.0,
                                ),
                            ],
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
                  StreamBuilder<Map<Events, bool>>(
                      stream: tweetCanvasBloc.stateCustomToggleStream,
                      initialData: {
                        Events.ShowLikes: true,
                        Events.ShowRetweets: true,
                        Events.ShowComments: true,
                        Events.ShowDate: true,
                      },
                      builder: (context, snapshot) {
                        return Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Visibility(
                                visible: (snapshot.data
                                        as Map<Events, bool>)[Events.ShowDate]
                                    as bool,
                                child: Text(
                                  DateFormat('h:mm a · MMM d, yyyy')
                                      .format(tweet.data[0].createdAt),
                                  style: TextStyle(
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey),
                                ),
                              ),
                              SizedBox(height: 10.0),
                              Row(
                                children: <Widget>[
                                  Visibility(
                                    visible: (snapshot.data as Map<Events,
                                        bool>)[Events.ShowLikes] as bool,
                                    child: Row(
                                      children: [
                                        Container(
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.favorite,
                                                color: Colors.pink,
                                                size: 16.0,
                                                semanticLabel:
                                                    'Text to announce in accessibility modes',
                                              ),
                                              SizedBox(width: 5.0),
                                              Text(
                                                tweet.data[0].publicMetrics
                                                    .likeCount
                                                    .toString(),
                                                style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              SizedBox(width: 32.0),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Visibility(
                                    visible: (snapshot.data as Map<Events,
                                        bool>)[Events.ShowRetweets] as bool,
                                    child: Container(
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.repeat,
                                            color: Colors.green,
                                            size: 16.0,
                                          ),
                                          SizedBox(width: 5.0),
                                          Text(
                                            tweet.data[0].publicMetrics
                                                .retweetCount
                                                .toString(),
                                            style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          SizedBox(width: 32.0),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                    visible: (snapshot.data as Map<Events,
                                        bool>)[Events.ShowComments] as bool,
                                    child: Container(
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.mode_comment_outlined,
                                            color: Colors.blueGrey,
                                            size: 16.0,
                                          ),
                                          SizedBox(width: 5.0),
                                          Text(
                                            tweet.data[0].publicMetrics
                                                .replyCount
                                                .toString(),
                                            style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }),
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
          },
        ),
      ),
    );
  }
}
