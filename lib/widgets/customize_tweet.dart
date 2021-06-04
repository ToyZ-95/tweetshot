import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:tweetshot/blocs/tweet_canvas_bloc.dart';
import 'package:tweetshot/widgets/custom_toggle.dart';

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
    print('abcd');
    showModalBottomSheet(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        context: context,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height - 400.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ColorPicker(
                  onColorChanged: (Color value) {
                    tweetCanvasBloc.setCanvasColor(value);
                  },
                  pickerColor: tweetCanvasBloc.canvasColor,
                  showLabel: true,
                  pickerAreaHeightPercent: 0.70,
                ),
              ],
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
                CustomToggle(
                    text: 'Background',
                    icon: Icon(
                      Icons.color_lens_outlined,
                    ),
                    onPressed: openColorPicker),
                SizedBox(
                  width: 10.0,
                ),
                CustomToggle(
                    text: 'Likes',
                    icon: Icon(Icons.favorite),
                    onPressed: () {}),
                SizedBox(
                  width: 10.0,
                ),
                CustomToggle(
                    text: 'Retweet',
                    icon: Icon(Icons.repeat),
                    onPressed: () {}),
                SizedBox(
                  width: 10.0,
                ),
                CustomToggle(
                    text: 'Comment',
                    icon: Icon(Icons.mode_comment_outlined),
                    onPressed: () {}),
                SizedBox(
                  width: 10.0,
                ),
                CustomToggle(
                    text: 'Date',
                    icon: Icon(Icons.date_range),
                    onPressed: () {}),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
