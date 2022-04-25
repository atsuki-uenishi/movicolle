import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class ThemeColorProvider with ChangeNotifier {
  MaterialColor? primaryColor = Colors.blue;

  void setColor(MaterialColor newColor) {
    primaryColor = newColor;
    notifyListeners();
  }
}
