import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import 'package:tweetshot/blocs/tweet_canvas_bloc.dart';
import 'package:tweetshot/widgets/custom_toggle.dart';

class CustomizeTweet extends StatefulWidget {
  final TweetCanvasBloc tweetCanvasBloc;
  final ScreenshotController screenshotController;
  CustomizeTweet(
      {required this.tweetCanvasBloc, required this.screenshotController});
  @override
  _CustomizeTweetState createState() => _CustomizeTweetState(
      tweetCanvasBloc: this.tweetCanvasBloc,
      screenshotController: this.screenshotController);
}

class _CustomizeTweetState extends State<CustomizeTweet> {
  final TweetCanvasBloc tweetCanvasBloc;
  final ScreenshotController screenshotController;
  _CustomizeTweetState(
      {required this.tweetCanvasBloc, required this.screenshotController});

  void openColorPicker() {
    print('abcd');
    showModalBottomSheet(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
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
      },
    );
  }

  void saveImage() async {
    if (await Permission.storage.request().isGranted) {
      screenshotController.capture(delay: Duration(milliseconds: 10)).then(
        (Uint8List? image) async {
          // _imageFile = image;
          if (image != null) {
            await ImageGallerySaver.saveImage(image);
          }
        },
      );
    }
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
                  onPressed: () => tweetCanvasBloc.eventCustomToggleSink
                      .add(Events.ShowLikes),
                ),
                SizedBox(
                  width: 10.0,
                ),
                CustomToggle(
                  text: 'Retweet',
                  icon: Icon(Icons.repeat),
                  onPressed: () => tweetCanvasBloc.eventCustomToggleSink
                      .add(Events.ShowRetweets),
                ),
                SizedBox(
                  width: 10.0,
                ),
                CustomToggle(
                  text: 'Comment',
                  icon: Icon(Icons.mode_comment_outlined),
                  onPressed: () => tweetCanvasBloc.eventCustomToggleSink
                      .add(Events.ShowComments),
                ),
                SizedBox(
                  width: 10.0,
                ),
                CustomToggle(
                  text: 'Date',
                  icon: Icon(Icons.date_range),
                  onPressed: () => tweetCanvasBloc.eventCustomToggleSink
                      .add(Events.ShowDate),
                ),
                SizedBox(
                  width: 10.0,
                ),
                CustomToggle(
                  text: 'Save',
                  icon: Icon(Icons.save_outlined),
                  onPressed: saveImage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
