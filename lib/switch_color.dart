import 'package:flutter/material.dart';

class SwitchColor {
  static Color switchColor(MaterialColor? color) {
    if (color == Colors.red) {
      return Colors.red;
    } else if (color == Colors.blue) {
      return Colors.blue;
    } else if (color == Colors.yellow) {
      return Colors.yellow;
    } else if (color == Colors.green) {
      return Colors.green;
    } else if (color == Colors.purple) {
      return Colors.purple;
    } else if (color == Colors.orange) {
      return Colors.orange;
    } else if (color == Colors.pink) {
      return Colors.pink;
    } else if (color == Colors.brown) {
      return Colors.brown;
    } else if (color == Colors.blue) {
      return Colors.grey;
    } else {
      return Colors.blue;
    }
  }
}
