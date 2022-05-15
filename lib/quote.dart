import 'dart:typed_data';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quotesmaker/layout/sidebar.dart';
import 'package:quotesmaker/provider/drawer_provider.dart';
import 'package:quotesmaker/provider/file_management_provider.dart';
import 'package:screenshot/screenshot.dart';

class QuotePage extends StatefulWidget {
  const QuotePage({Key? key}) : super(key: key);

  @override
  State<QuotePage> createState() => _QuotePageState();
}

class _QuotePageState extends State<QuotePage> {
  @override
  Widget build(BuildContext context) {
    final DrawerProvider _drawerProvider = Provider.of<DrawerProvider>(context);
    final FileManagementProvider _fileManagementProvider =
        Provider.of<FileManagementProvider>(context);

    return Scaffold(
      backgroundColor: Colors.black12,
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              _drawerProvider.toggleDrawer();
            }),
      ),
      body: Row(
        children: [
          const SideBar(),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(top: 50),
              constraints:
                  const BoxConstraints(minWidth: 1200, minHeight: 1000),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 200,
                            width: 400,
                            child: TextField(
                              controller:
                                  _fileManagementProvider.quotesTextController,
                              maxLines: 30,
                              minLines: 30,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  hintText: 'Enter quotes one in a line'),
                            ),
                          ),
                          Container(
                            width: 400,
                            margin: const EdgeInsets.only(top: 20),
                            child: TextField(
                              maxLength: 4,
                              enabled: false,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: InputDecoration(
                                  counter: const SizedBox.shrink(),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  hintText: 'Quantity'),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              _fileManagementProvider.generatePicture(
                                  width: 500,
                                  height: 500,
                                  color: Colors.pink.shade100);
                            },
                            child: Container(
                              margin: const EdgeInsets.only(top: 20),
                              alignment: Alignment.center,
                              width: 400,
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Theme.of(context).primaryColor),
                              child: const Text(
                                'Generate Now',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 30),
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          StreamBuilder<Widget>(
                              stream: _fileManagementProvider.quoteStream,
                              builder: (context, snapshot) {
                                return Screenshot(
                                  controller: _fileManagementProvider
                                      .screenshotController,
                                  child: snapshot.data ?? QuotesWidget(quote:_fileManagementProvider.quotesTextController.text.split("\n")[0]),
                                );
                              }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // _save() async {
  //   // _screenshotController
  //   //     .capture(delay: const Duration(milliseconds: 10))
  //   //     .then((capturedImage) async {})
  //   //     .catchError((onError) {});
  //   // await FileSaver.instance
  //   //     .saveFile('quote_', image, 'png', mimeType: MimeType.PNG);
  // }
}

class QuotesWidget extends StatelessWidget {
  final Color color;
  final double borderRadius;
  final double fontSize;
  final FontWeight fontWeight;
  final double lineHeight;
  final double width;
  final double height;
  final String quote;

  const QuotesWidget({
    Key? key,
    this.width = 512,
   this.height = 512,
    this.color = Colors.white,
    this.borderRadius = 2.0,
    this.fontSize = 40,
    this.fontWeight = FontWeight.bold,
    this.lineHeight = 1.5,
    this.quote = 'Don\'t comment bad code - rewrite it.'
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset("bg2.png", width: width, height: height, fit: BoxFit.cover),
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
                fontSize: fontSize, fontWeight: fontWeight, height: lineHeight),
          ),
        )
      ],
    );
  }
}
