import 'package:flutter/foundation.dart';
export 'package:provider/provider.dart';

class DrawerProvider extends ChangeNotifier {
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
