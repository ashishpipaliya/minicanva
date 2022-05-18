import 'dart:async';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:screenshot/screenshot.dart';
enum ColorType{
  background, text
}
class FileManagementProvider extends ChangeNotifier {
  final TextEditingController quotesTextController = TextEditingController();
  final ScreenshotController screenshotController = ScreenshotController();



  Color? selectedColor;
  colorChange(Color color) {
    selectedColor = color;
    notifyListeners();
  }


  Color? selectedTextColor;
  textColorChange(Color color) {
    selectedTextColor = color;
    notifyListeners();
  }


  double selectedRadius = 5.0;
  radiusChange(double radius) {
    selectedRadius = radius;
    notifyListeners();
  }

  double selectedHeight = 400;
  heightChange(double height) {
    selectedHeight = height;
    notifyListeners();
  }

  double selectedWidth = 400;
  widthChange(double width) {
    selectedWidth = width;
    notifyListeners();
  }

  double selectedFontSize = 35;
  fontSizeChange(double size) {
    selectedFontSize = size;
    notifyListeners();
  }

  double selectedLineHeight = 1.0;
  lineHeightChange(double h) {
    selectedLineHeight = h;
    notifyListeners();
  }

  FontWeight selectedFontWeight = FontWeight.bold;
  fontWeightChange(FontWeight w) {
    selectedFontWeight = w;
    notifyListeners();
  }

  Alignment align =Alignment.center;
  textPositionChange(Alignment position) {
    align = position;
    notifyListeners();
  }

  String selectedFont ='Lato';
  fontChange(String font) {
    selectedFont = font;
    notifyListeners();
  }

  String backgroundImage =assetImages.first;
  backgroundImageChange(String asset) {
    backgroundImage = asset;
    print(backgroundImage);
    notifyListeners();
  }

  String _quote_0 = '';
  String get quoteToFront =>_quote_0;
  changeQuote(String newQuote){
    _quote_0 = newQuote;
    notifyListeners();
  }

  final StreamController<String> _quoteStreamController =
  StreamController<String>.broadcast();
  Stream<String> get quoteStream => _quoteStreamController.stream;

  generatePicture() async {
    List<String> quotesList = quotesTextController.text.split("\n");
    // quotesTextController.clear();

    for (var quote in quotesList) {
      _quoteStreamController.sink.add(quote);

      await Future.delayed(const Duration(seconds: 1));
      Widget quoteWidget = Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(selectedRadius),
            child: Image.asset(backgroundImage,
                width: selectedWidth,
                height: selectedHeight,
                fit: BoxFit.cover),
          ),
          Container(
            width: selectedWidth,
            height: selectedHeight,
            padding: const EdgeInsets.all(50),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(selectedRadius),
                color: selectedColor),
          ),
          Container(
            alignment: align,
            width: selectedWidth,
            height: selectedHeight,
            padding: const EdgeInsets.all(25),
            child: Text(
             quote,
              textAlign: TextAlign.center,
              style: GoogleFonts.getFont(selectedFont,
                  color: selectedTextColor,
                  fontSize: selectedFontSize,
                  fontWeight: selectedFontWeight,
                  height: selectedLineHeight),
            ),
          )
        ],
      );
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
  }
}

List<String> assetImages = [
  'assets/t1.png',
  'assets/t2.png',
  'assets/t3.png',
  'assets/t4.png',
  'assets/t5.png',
  'assets/t6.png',
  'assets/t7.png',
  'assets/t8.png',
  'assets/t9.png',
  'assets/t10.png',
  'assets/t11.png',
  'assets/t12.png',
  'assets/t13.png',
  'assets/t14.png',
  'assets/t15.png',
  'assets/t16.png',
  'assets/t17.png',
  'assets/t18.png',
  'assets/t19.png'
];








// All our dreams can come true, if we have the courage to pursue them.
// The secret of getting ahead is getting started.
// I've missed more than 9,000 shots in my career. I’ve lost almost 300 games. 26 times I’ve been trusted to take the game winning shot and missed. I’ve failed over and over and over again in my life and that is why I succeed
// Don't limit yourself. Many people limit themselves to what they think they can do. You can go as far as your mind lets you. What you believe, remember, you can achieve
// The best time to plant a tree was 20 years ago. The second best time is now.
// It's hard to beat a person who never gives up
// I wake up every morning and think to myself, 'how far can I push this company in the next 24 hours.'
// If people are doubting how far you can go, go so far that you can’t hear them anymore
// We need to accept that we won't always make the right decisions, that we'll screw up royally sometimes – understanding that failure is not the opposite of success, it's part of success.