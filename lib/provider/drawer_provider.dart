import 'package:flutter/material.dart';
export 'package:provider/provider.dart';

class DrawerProvider extends ChangeNotifier {

  int selectedIndex = 0;

  changeIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  bool _isDrawerOpened = true;

  bool get isDrawer => _isDrawerOpened;

  toggleDrawer() async {
    _isDrawerOpened = !_isDrawerOpened;
    notifyListeners();
  }

  bool _showLabel = false;

  bool get showLabel => _showLabel;

  showLabelText() async {
    _showLabel = !_showLabel;
    notifyListeners();
  }

}
