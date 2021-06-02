import 'package:flutter/material.dart';
import 'tweet_modification_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController tweetLinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: tweetLinController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter tweet link',
                    labelText: 'Tweet link'),
              ),
              SizedBox(
                height: 50.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TweetModificationPage(
                            tweetLink: tweetLinController.text),
                      ),
                    );
                  },
                  style:
                      TextButton.styleFrom(backgroundColor: Colors.blueAccent),
                  child: Text(
                    'Get Tweet',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
