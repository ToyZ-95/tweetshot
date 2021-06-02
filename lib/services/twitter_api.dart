import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tweetshot/models/tweet.dart';

class TwitterApi {
  final String bearer;

  TwitterApi(this.bearer);

  Future<Tweet> getTweet(String id) async {
    Uri uri;

    //const base = 'https://api.twitter.com/2/tweets';

    const expansions = 'author_id,attachments.media_keys';
    const userFields = 'profile_image_url,verified';
    const tweetFields = 'created_at,public_metrics';
    const mediaFields = 'height,width,type,url,preview_image_url';

    uri = Uri.https(
      'api.twitter.com',
      '/2/tweets',
      {
        'ids': id,
        'expansions': expansions,
        'tweet.fields': tweetFields,
        'user.fields': userFields,
        'media.fields': mediaFields,
      },
    );

    var res = await http.get(
      uri,
      headers: {'Authorization': 'Bearer ${this.bearer}'},
    );

    if (res.statusCode == 200) {
      print(jsonDecode(res.body));
      return Tweet.fromJson(jsonDecode(res.body));
    }

    throw res.statusCode;
  }
}
