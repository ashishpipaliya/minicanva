import 'dart:async';
import 'dart:io';

import 'package:archive/archive_io.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';

class FileManagementProvider extends ChangeNotifier {
  final TextEditingController quotesTextController = TextEditingController();
  final ScreenshotController screenshotController = ScreenshotController();

  final StreamController<Widget> _quoteStreamController =
      StreamController<Widget>();
  Stream<Widget> get quoteStream => _quoteStreamController.stream;

  generatePicture(
      {Color color = Colors.white,
      double borderRadius = 2.0,
      double fontSize = 40,
      FontWeight fontWeight = FontWeight.bold,
      double lineHeight = 1.5,
      required double width,
      required double height}) async {
    List<String> quotesList = quotesTextController.text.split("\n");
    quotesTextController.clear();

    for (var quote in quotesList) {
      Widget quoteWidget = Stack(
        children: [
          Image.asset("bg2.png",
              width: width, height: height, fit: BoxFit.cover),
          Container(
            width: width,
            height: height,
            padding: const EdgeInsets.all(50),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(borderRadius),
                color: color.withOpacity(0.1)),
            alignment: Alignment.center,
            child: Text(
              quote,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: fontWeight,
                  height: lineHeight),
            ),
          )
        ],
      );

      _quoteStreamController.sink.add(quoteWidget);
      await Future.delayed(const Duration(seconds: 1));

      screenshotController
          .captureFromWidget(quoteWidget,
              delay: const Duration(milliseconds: 10))
          .then((capturedImage) async {
        await FileSaver.instance.saveFile(
            'quote_${quotesList.indexOf(quote) + 1}', capturedImage, 'png',
            mimeType: MimeType.PNG);
      }).catchError((onError) {
        print(onError);
      });
      // screenshotController
      //     .capture(delay: const Duration(milliseconds: 10))
      //     .then((capturedImage) async {
      //   await FileSaver.instance.saveFile(
      //       'quote_${quotesList.indexOf(quote) + 1}', capturedImage!, 'png',
      //       mimeType: MimeType.PNG);
      // }).catchError((onError) {});
    }
    _quoteStreamController.close();
  }
}










// All our dreams can come true, if we have the courage to pursue them.
// The secret of getting ahead is getting started.
// I've missed more than 9,000 shots in my career. I’ve lost almost 300 games. 26 times I’ve been trusted to take the game winning shot and missed. I’ve failed over and over and over again in my life and that is why I succeed
// Don't limit yourself. Many people limit themselves to what they think they can do. You can go as far as your mind lets you. What you believe, remember, you can achieve
// The best time to plant a tree was 20 years ago. The second best time is now.
// It's hard to beat a person who never gives up
// I wake up every morning and think to myself, 'how far can I push this company in the next 24 hours.'
// If people are doubting how far you can go, go so far that you can’t hear them anymore
// We need to accept that we won't always make the right decisions, that we'll screw up royally sometimes – understanding that failure is not the opposite of success, it's part of success.