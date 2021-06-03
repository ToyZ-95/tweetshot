import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:tweetshot/blocs/tweet_canvas_bloc.dart';

class CustomizeTweet extends StatefulWidget {
  final TweetCanvasBloc tweetCanvasBloc;
  CustomizeTweet({required this.tweetCanvasBloc});
  @override
  _CustomizeTweetState createState() =>
      _CustomizeTweetState(tweetCanvasBloc: this.tweetCanvasBloc);
}

class _CustomizeTweetState extends State<CustomizeTweet> {
  final TweetCanvasBloc tweetCanvasBloc;

  _CustomizeTweetState({required this.tweetCanvasBloc});

  openColorPicker() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Choose color'),
            content: SingleChildScrollView(
              child: ColorPicker(
                onColorChanged: (Color value) {
                  tweetCanvasBloc.setCanvasColor(value);
                },
                pickerColor: tweetCanvasBloc.canvasColor,
                showLabel: true,
                pickerAreaHeightPercent: 0.8,
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.0,
      decoration: BoxDecoration(
        color: Color(0xffDCDCDC),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 3.0),
            child: Row(
              children: [
                CircleAvatar(
                  child: IconButton(
                      icon: Icon(Icons.color_lens_outlined),
                      onPressed: openColorPicker),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
