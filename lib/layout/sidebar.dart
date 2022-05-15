import 'dart:async';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:quotesmaker/provider/drawer_provider.dart';

class SideBar extends StatefulWidget {
  const SideBar({Key? key}) : super(key: key);

  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> with SingleTickerProviderStateMixin {
  // int selectedIndex = 0;
  final StreamController<int> _indexStream = StreamController<int>.broadcast();


  @override
  Widget build(BuildContext context) {
    final DrawerProvider _drawerProvider = Provider.of<DrawerProvider>(context);
    return Visibility(
      visible: _drawerProvider.isDrawer,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(
          children: [
            const Spacer(),
            Column(
              children: List.generate(
                items.length,
                (index) => _buildMenuItem(index, _drawerProvider),
              ),
            ),
            const Spacer(),
            IconButton(
                onPressed: _drawerProvider.showLabelText,
                icon: Icon(!_drawerProvider.showLabel
                    ? Icons.arrow_forward_ios
                    : Icons.arrow_back_ios))
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(int index, DrawerProvider dp) {
    // bool isSelected = selectedIndex == index;
    return StreamBuilder<int>(
        stream: _indexStream.stream,
        initialData: 0,
        builder: (context, _snap) {
          return Container(
            margin: const EdgeInsets.only(bottom: 20),
            child: Material(
              borderRadius: BorderRadius.circular(10),
              color: _snap.data == index
                  ? Theme.of(context).primaryColor.withOpacity(.1)
                  : null,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    IconButton(
                      color: _snap.data == index
                          ? Theme.of(context).primaryColor
                          : null,
                      icon: Icon(items[index].icon),
                      onPressed: () {
                        _indexStream.sink.add(index);
                        // setState(() => selectedIndex = index);
                      },
                    ),
                    Visibility(
                        visible: dp.showLabel,
                        child: SizedBox(
                                width: 100,
                                child: Text(items[index].title)))
                  ],
                ),
              ),
            ),
          );
        });
  }

  @override
  void dispose() {
    _indexStream.close();
    super.dispose();
  }
}

class MenuItem {
  String title;
  IconData icon;

  MenuItem(this.title, this.icon);
}

List<MenuItem> items = [
  MenuItem("Dashboard", Icons.dashboard),
  MenuItem("Explore", Icons.graphic_eq),
  MenuItem("Business", Icons.auto_stories),
  MenuItem("Media", Icons.perm_media_rounded),
  MenuItem("Setting", Icons.message)
];
