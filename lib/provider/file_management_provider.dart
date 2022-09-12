import 'dart:async';
import 'dart:math';
import 'dart:typed_data';
import 'package:download/download.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quotesmaker/utils/image_widget.dart';
import 'package:screenshot/screenshot.dart';

enum ColorType { background, text }

class FileManagementProvider extends ChangeNotifier {
  final TextEditingController quotesTextController = TextEditingController();
  final ScreenshotController screenshotController = ScreenshotController();

  Color? selectedColor;

  colorChange(Color color) {
    selectedColor = color;
    notifyListeners();
  }

  Color selectedTextColor = Colors.black;

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

  Alignment align = Alignment.center;

  textPositionChange(Alignment position) {
    align = position;
    notifyListeners();
  }

  String selectedFont = 'Lato';

  fontChange(String font) {
    selectedFont = font;
    notifyListeners();
  }

  bool isNetworkImage = false;

  String backgroundImage = assetImages[2];

  backgroundImageChange(String asset) {
    if (asset == 'assets/random.png') {
      backgroundImage = assetImages[Random().nextInt(assetImages.length)];
    } else {
      backgroundImage = asset;
    }
    notifyListeners();
  }

  double horizontalPadding = 50;

  horizontalPaddingChange(double padding) {
    horizontalPadding = padding;
    notifyListeners();
  }

  double verticalPadding = 50;

  verticalPaddingChange(double padding) {
    verticalPadding = padding;
    notifyListeners();
  }

  String _progress = '';

  String get progress => _progress;

  progressListener(int count, int length) {
    _progress = 'Download $count/$length complete';
    notifyListeners();
  }

  bool _isProcessing = false;

  bool get isProcessing => _isProcessing;

  processingChange(bool flag) {
    _isProcessing = flag;
    notifyListeners();
  }

  String _quote_0 = '';

  String get quoteToFront => _quote_0;

  changeQuote(String newQuote) {
    _quote_0 = newQuote;
    notifyListeners();
  }

  final StreamController<String> _quoteStreamController =
      StreamController<String>.broadcast();

  Stream<String> get quoteStream => _quoteStreamController.stream;

  generatePicture() async {
    List<String> quotesList = quotesTextController.text.split("\n");
    // quotesTextController.clear();
    processingChange(true);
    List<Future<void>> ssList = [];
    for (String quote in quotesList) {
      Widget quoteWidget = Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(selectedRadius),
            child: ImageWidget(
                urlOrPath: backgroundImage == 'assets/random.png'
                    ? assetImages[Random().nextInt(assetImages.length)]
                    : backgroundImage,
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
            padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding, vertical: verticalPadding),
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
      Uint8List output = await screenshotController.captureFromWidget(
          quoteWidget,
          delay: const Duration(milliseconds: 0));
      Future<void> imageData = download(Stream.fromIterable(output),
          'quote_${DateTime.now().microsecondsSinceEpoch}.png');
      ssList.add(imageData);
    }
    await Future.wait([...ssList]);
    processingChange(false);
  }
}

List<String> assetImages = [
  'assets/random.png',
  'assets/WHITE1.png',
  'assets/BLACK1.jpg',
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

List<String> networkImages = [
  'https://images.unsplash.com/photo-1436397543931-01c4a5162bdb?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80',
  'https://images.unsplash.com/photo-1441861187324-6970a2587e34?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80',
  'https://images.unsplash.com/photo-1477093782505-e10aaeb27c6d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80',
  'https://images.unsplash.com/photo-1481627834876-b7833e8f5570?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=928&q=80',
  'https://images.unsplash.com/photo-1528459401087-8b053910a2f6?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=857&q=80',
  'https://images.unsplash.com/photo-1454789548928-9efd52dc4031?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80',
  'https://images.unsplash.com/photo-1504238624541-bca0f332da07?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80',
  'https://images.unsplash.com/photo-1536329583941-14287ec6fc4e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80',
  'https://images.unsplash.com/photo-1528458805188-8774877fdb71?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=940&q=80',
  'https://images.unsplash.com/photo-1532117364815-720cd35ff6e3?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80',
  'https://images.unsplash.com/photo-1489648022186-8f49310909a0?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=910&q=80',
  'https://images.unsplash.com/photo-1574169208507-84376144848b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=879&q=80',
  'https://images.unsplash.com/photo-1483638994033-15b73fe7af18?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80',
  'https://images.unsplash.com/photo-1514891043184-4e5d100ee446?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80',
  'https://images.unsplash.com/photo-1443926818681-717d074a57af?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80',
  'https://images.unsplash.com/photo-1491947153227-33d59da6c448?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80',
  'https://images.unsplash.com/photo-1492293356863-25beabc4267b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=882&q=80',
  'https://images.unsplash.com/photo-1465515771403-eb9fe92e9a8f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80',
  'https://images.unsplash.com/photo-1494548162494-384bba4ab999?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80',
  'https://images.unsplash.com/photo-1518715058720-e56f02e77fe5?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80',
  'https://images.unsplash.com/photo-1471970471555-19d4b113e9ed?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80',
  'https://images.unsplash.com/photo-1494791368093-85217fbbf8de?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80',
  'https://images.unsplash.com/photo-1471047283799-ebd97acc0bc3?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80',
  'https://images.unsplash.com/photo-1521572063439-8a4186b6d843?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80',
  'https://images.unsplash.com/photo-1568738351265-c7065f5d4293?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80',
  'https://images.unsplash.com/photo-1512389055488-8d82cb26ba6c?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=683&q=80',
  'https://images.unsplash.com/photo-1533122250115-6bb28e9a48c3?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=735&q=80',
  'https://images.unsplash.com/photo-1570960197864-88cd9a6439ba?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1325&q=80',
  'https://images.unsplash.com/photo-1496715976403-7e36dc43f17b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
  'https://images.unsplash.com/photo-1524055988636-436cfa46e59e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=735&q=80',
  'https://images.unsplash.com/photo-1517196084897-498e0abd7c2d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80',
  'https://images.unsplash.com/photo-1533899114961-3aa0579cd5b8?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=672&q=80',
  'https://images.unsplash.com/photo-1460602692976-8eab38c11f9d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1176&q=80',
  'https://images.unsplash.com/photo-1488867605300-0380106bc701?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=673&q=80',
  'https://images.unsplash.com/photo-1606486544554-164d98da4889?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80',
  'https://images.unsplash.com/photo-1506508618093-6fe5ce3def4c?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1074&q=80',
  'https://images.unsplash.com/photo-1551554781-c46200ea959d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
  'https://images.unsplash.com/photo-1497864149936-d3163f0c0f4b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1169&q=80',
  'https://images.unsplash.com/photo-1528460033278-a6ba57020470?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=735&q=80',
  'https://images.unsplash.com/photo-1501236570302-906143a7c9f8?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1074&q=80',
  'https://images.unsplash.com/photo-1517856713891-215e57a13c0d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1169&q=80',
  'https://images.unsplash.com/photo-1513205018065-e8cfb0f02c3f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=735&q=80',
  'https://images.unsplash.com/photo-1491947153227-33d59da6c448?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80',
  'https://images.unsplash.com/photo-1613222527525-6bc31b2f3075?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
  'https://images.unsplash.com/photo-1572707582365-0ee1c8e71173?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
  'https://images.unsplash.com/photo-1517524285303-d6fc683dddf8?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=735&q=80',
  'https://images.unsplash.com/photo-1516796181074-bf453fbfa3e6?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
  'https://images.unsplash.com/photo-1531824475211-72594993ce2a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
  'https://images.unsplash.com/photo-1593762606956-94099e96cc16?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80',
  'https://images.unsplash.com/photo-1598804186557-95e302c7b0a7?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=827&q=80',
  'https://images.unsplash.com/photo-1617783919255-b36e439deeda?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80',
  'https://images.unsplash.com/photo-1597239182940-fefb7bdb326d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=837&q=80',
  'https://images.unsplash.com/photo-1583265627959-fb7042f5133b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80',
  'https://images.unsplash.com/photo-1617750213248-3f91c3d55be6?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80',
  'https://images.unsplash.com/photo-1454789548928-9efd52dc4031?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80',
  'https://images.unsplash.com/photo-1615493932251-71495614f3ab?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=827&q=80',
  'https://images.unsplash.com/photo-1654473056166-3eef5f16e49f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=905&q=80',
  'https://images.unsplash.com/photo-1609678379377-f0cc40cb32d2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80',
  'https://images.unsplash.com/photo-1511553677255-ba939e5537e0?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=928&q=80',
  'https://images.unsplash.com/photo-1496989981497-27d69cdad83e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=931&q=80',
  'https://images.unsplash.com/photo-1613142289371-766e4f568cff?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=832&q=80',
  'https://images.unsplash.com/photo-1490814525860-594e82bfd34a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=895&q=80',
  'https://images.unsplash.com/photo-1590907047706-ee9c08cf3189?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80',
  'https://images.unsplash.com/photo-1590388143860-6594f1fbc1f4?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80',
  'https://images.unsplash.com/photo-1504238624541-bca0f332da07?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80',
  'https://images.unsplash.com/photo-1630940586712-34e584769196?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=862&q=80',
  'https://images.unsplash.com/photo-1649077551789-dcb02002c7d8?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80',
  'https://images.unsplash.com/photo-1545358108-2428cf334d24?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80',
  'https://images.unsplash.com/photo-1557573440-45f4aa426786?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=850&q=80',
  'https://images.unsplash.com/photo-1556296569-44d434fb28d6?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80'
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
