// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Tweet welcomeFromJson(String str) => Tweet.fromJson(json.decode(str));

String welcomeToJson(Tweet data) => json.encode(data.toJson());

class Tweet {
  Tweet({
    required this.data,
    required this.includes,
  });

  List<Datum> data;
  Includes includes;

  factory Tweet.fromJson(Map<String, dynamic> json) => Tweet(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        includes: Includes.fromJson(json["includes"]),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "includes": includes.toJson(),
      };
}

class Datum {
  Datum({
    required this.publicMetrics,
    required this.id,
    required this.createdAt,
    required this.text,
    required this.authorId,
  });

  PublicMetrics publicMetrics;
  String id;
  DateTime createdAt;
  String text;
  String authorId;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        publicMetrics: PublicMetrics.fromJson(json["public_metrics"]),
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        text: json["text"],
        authorId: json["author_id"],
      );

  Map<String, dynamic> toJson() => {
        "public_metrics": publicMetrics.toJson(),
        "id": id,
        "created_at": createdAt.toIso8601String(),
        "text": text,
        "author_id": authorId,
      };
}

class PublicMetrics {
  PublicMetrics({
    required this.retweetCount,
    required this.replyCount,
    required this.likeCount,
    required this.quoteCount,
  });

  int retweetCount;
  int replyCount;
  int likeCount;
  int quoteCount;

  factory PublicMetrics.fromJson(Map<String, dynamic> json) => PublicMetrics(
        retweetCount: json["retweet_count"],
        replyCount: json["reply_count"],
        likeCount: json["like_count"],
        quoteCount: json["quote_count"],
      );

  Map<String, dynamic> toJson() => {
        "retweet_count": retweetCount,
        "reply_count": replyCount,
        "like_count": likeCount,
        "quote_count": quoteCount,
      };
}

class Includes {
  Includes({
    required this.users,
  });

  List<User> users;

  factory Includes.fromJson(Map<String, dynamic> json) => Includes(
        users: List<User>.from(json["users"].map((x) => User.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "users": List<dynamic>.from(users.map((x) => x.toJson())),
      };
}

class User {
  User({
    required this.verified,
    required this.id,
    required this.username,
    required this.name,
    required this.profileImageUrl,
  });

  bool verified;
  String id;
  String username;
  String name;
  String profileImageUrl;

  factory User.fromJson(Map<String, dynamic> json) => User(
        verified: json["verified"],
        id: json["id"],
        username: json["username"],
        name: json["name"],
        profileImageUrl: json["profile_image_url"],
      );

  Map<String, dynamic> toJson() => {
        "verified": verified,
        "id": id,
        "username": username,
        "name": name,
        "profile_image_url": profileImageUrl,
      };
}
