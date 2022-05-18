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
            Row(
              children: [
                Column(
                  children: List.generate(
                    items.length,
                    (index) => _buildMenuItem(index, _drawerProvider),
                  ),
                ),
                IconButton(
                    onPressed: _drawerProvider.showLabelText,
                    icon: Icon(!_drawerProvider.showLabel ? Icons.arrow_forward_ios : Icons.arrow_back_ios))
              ],
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(int index, DrawerProvider dp) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Material(
        borderRadius: BorderRadius.circular(10),
        color: dp.selectedIndex == index ? Theme.of(context).primaryColor.withOpacity(.1) : null,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              IconButton(
                color: dp.selectedIndex == index ? Theme.of(context).primaryColor : null,
                icon: Icon(items[index].icon),
                onPressed: () {
                  dp.changeIndex(index);
                  // setState(() => selectedIndex = index);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class MenuItem {
  String title;
  IconData icon;
  Widget child;

  MenuItem(this.title, this.icon, this.child);
}

List<MenuItem> items = [
  MenuItem("Dashboard", Icons.dashboard, Container()),
  MenuItem("Explore", Icons.graphic_eq, Container()),
  MenuItem("Business", Icons.auto_stories, Container())
];
