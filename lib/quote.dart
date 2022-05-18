import 'dart:typed_data';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:google_fonts/google_fonts.dart';
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
    final FileManagementProvider _fileManagementProvider = Provider.of<FileManagementProvider>(context);
    Size _size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.cyan.shade100,
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              _drawerProvider.toggleDrawer();
            }),
      ),
      body: Row(
        children: [
          // const SideBar(),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(top: 50, left: 50),
              width: _size.width, height: _size.height,
              // constraints: const BoxConstraints(minWidth: 1000, minHeight: 1000),
              child: SingleChildScrollView(
                controller: ScrollController(),
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SingleChildScrollView(
                      controller: ScrollController(),
                      child: Column(
                        children: [
                          SizedBox(
                            width: 400,
                            height: 100,
                            child: TextField(
                              controller: _fileManagementProvider.quotesTextController,
                              maxLines: null,
                              minLines: 5,
                              decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                                  hintText: 'Enter quotes one in a line'),
                            ),
                          ),
                          Container(
                            width: 400,
                            margin: const EdgeInsets.only(top: 20),
                            child: TextField(
                              maxLength: 4,
                              enabled: false,
                              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                              decoration: InputDecoration(
                                  counter: const SizedBox.shrink(),
                                  fillColor: Colors.white,
                                  filled: true,
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                                  hintText: 'Quantity'),
                            ),
                          ),
                          Container(
                            width: 400,
                            margin: const EdgeInsets.only(top: 20),
                            child: Row(
                              children: [
                                Flexible(
                                  child: TextField(
                                    maxLength: 4,
                                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                    onChanged: (val) {
                                      _fileManagementProvider.widthChange(double.parse(val));
                                    },
                                    decoration: InputDecoration(
                                        counter: const SizedBox.shrink(),
                                        fillColor: Colors.white,
                                        filled: true,
                                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                                        hintText: 'Width'),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Flexible(
                                  child: TextField(
                                    maxLength: 4,
                                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                    onChanged: (val) {
                                      _fileManagementProvider.heightChange(double.tryParse(val)!);
                                    },
                                    decoration: InputDecoration(
                                        counter: const SizedBox.shrink(),
                                        fillColor: Colors.white,
                                        filled: true,
                                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                                        hintText: 'Height'),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Flexible(
                                  child: TextField(
                                    maxLength: 2,
                                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                    onChanged: (val) {
                                      _fileManagementProvider.radiusChange(double.parse(val));
                                    },
                                    decoration: InputDecoration(
                                        counter: const SizedBox.shrink(),
                                        fillColor: Colors.white,
                                        filled: true,
                                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                                        hintText: 'Radius'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 400,
                            margin: const EdgeInsets.only(top: 20),
                            child: Row(
                              children: [
                                Flexible(
                                  child: GestureDetector(
                                    onTap: () => _openColorPicker(_fileManagementProvider, ColorType.background),
                                    child: Container(
                                      decoration:
                                          BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
                                      child: AbsorbPointer(
                                        child: TextField(
                                          decoration: InputDecoration(
                                              fillColor: _fileManagementProvider.selectedColor ?? Colors.white,
                                              filled: _fileManagementProvider.selectedColor != null,
                                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                                              hintText: 'Color'),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Flexible(
                                  child: GestureDetector(
                                    onTap: () => _openColorPicker(_fileManagementProvider, ColorType.text),
                                    child: Container(
                                      decoration:
                                          BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
                                      child: AbsorbPointer(
                                        child: TextField(
                                          decoration: InputDecoration(
                                              fillColor: _fileManagementProvider.selectedTextColor ?? Colors.white,
                                              filled: _fileManagementProvider.selectedTextColor != null,
                                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                                              hintText: 'Text color'),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Flexible(
                                  child: TextField(
                                    inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d*'))],
                                    onChanged: (val) {
                                      _fileManagementProvider.lineHeightChange(double.parse(val));
                                    },
                                    decoration: InputDecoration(
                                        fillColor: Colors.white,
                                        filled: true,
                                        // counter: SizedBox.shrink(),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                        hintText: 'Line height'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 400,
                            margin: const EdgeInsets.only(top: 20),
                            child: Slider(
                                label: "Font size ${_fileManagementProvider.selectedFontSize}",
                                value: _fileManagementProvider.selectedFontSize,
                                min: 10,
                                max: 100,
                                divisions: 90,
                                onChanged: _fileManagementProvider.fontSizeChange),
                          ),
                          Container(
                            width: 400,
                            margin: const EdgeInsets.only(top: 20),
                            child: ButtonBar(alignment: MainAxisAlignment.center, children: [
                              TextButton(
                                  onPressed: () => _fileManagementProvider.textPositionChange(Alignment.topCenter),
                                  child: const Text("Top")),
                              TextButton(
                                  onPressed: () => _fileManagementProvider.textPositionChange(Alignment.center),
                                  child: const Text("Center")),
                              TextButton(
                                  onPressed: () => _fileManagementProvider.textPositionChange(Alignment.bottomCenter),
                                  child: const Text("Bottom")),
                            ]),
                          ),
                          GestureDetector(
                            onTap: () {
                              _fileManagementProvider.generatePicture();
                            },
                            child: Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.only(top: 20),
                              width: 400,
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15), color: Theme.of(context).primaryColor),
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
                    Column(children: [
                      Expanded(
                        child: SizedBox(
                          width: 300,
                          child: GridView.builder(
                            controller: ScrollController(),
                            shrinkWrap: true,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2, childAspectRatio: 2.5, crossAxisSpacing: 5, mainAxisSpacing: 5),
                            itemBuilder: (context, index) {
                              String font = GoogleFonts.asMap().keys.toList()[index];
                              return GestureDetector(
                                onTap: () => _fileManagementProvider.fontChange(font),
                                child: Container(
                                    width: 100,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black),
                                        borderRadius: BorderRadius.circular(15),
                                        color: Colors.white60),
                                    child: Text(
                                      font,
                                      textAlign: TextAlign.center,
                                    )),
                              );
                            },
                            itemCount: GoogleFonts.asMap().keys.toList().length,
                          ),
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          width: 300,
                          child: Container(child: Text("Frames here")),
                        ),
                      ),
                    ]),
                    const SizedBox(width: 30),
                    SingleChildScrollView(
                      controller: ScrollController(),
                      child: Column(
                        children: [
                          Screenshot(
                            controller: _fileManagementProvider.screenshotController,
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(_fileManagementProvider.selectedRadius),
                                  child: Image.asset("assets/bg2.png",
                                      width: _fileManagementProvider.selectedWidth,
                                      height: _fileManagementProvider.selectedHeight,
                                      fit: BoxFit.cover),
                                ),
                                Container(
                                  width: _fileManagementProvider.selectedWidth,
                                  height: _fileManagementProvider.selectedHeight,
                                  padding: const EdgeInsets.all(50),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(_fileManagementProvider.selectedRadius),
                                      color: _fileManagementProvider.selectedColor),
                                ),
                                Container(
                                  alignment: _fileManagementProvider.align,
                                  width: _fileManagementProvider.selectedWidth,
                                  height: _fileManagementProvider.selectedHeight,
                                  padding: const EdgeInsets.all(25),
                                  child: Text(
                                    'If people are doubting how far you can go, go so far that you can’t hear them anymore',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.getFont(_fileManagementProvider.selectedFont,
                                        color: _fileManagementProvider.selectedTextColor,
                                        fontSize: _fileManagementProvider.selectedFontSize,
                                        fontWeight: _fileManagementProvider.selectedFontWeight,
                                        height: _fileManagementProvider.selectedLineHeight),
                                  ),
                                )
                              ],
                            ),
                          )
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

  _openColorPicker(FileManagementProvider provider, ColorType type) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Pick a color!'),
              content: SingleChildScrollView(
                controller: ScrollController(),
                child: ColorPicker(
                  pickerColor: Theme.of(context).primaryColor,
                  onColorChanged: (color) =>
                      type == ColorType.background ? provider.colorChange(color) : provider.textColorChange(color),
                ),
              ),
              actions: [
                ElevatedButton(
                  child: const Text('Select'),
                  onPressed: () {
                    // provider.colorChange(color)
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ));
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
