import 'package:flutter/material.dart';

Color hexToColor(String hex) {
  assert(RegExp(r'^#([0-9a-fA-F]{6})|([0-9a-fA-F]{8})$').hasMatch(hex),
      'hex color must be #rrggbb or #rrggbbaa');

  return Color(
    int.parse(hex.substring(1), radix: 16) +
        (hex.length == 7 ? 0xff000000 : 0x00000000),
  );
}

class ColorConstants {
  static Color backgroundColor = hexToColor('#fefffe');
  static Color appBlue = hexToColor('#115DAC');
  static Color lightBlue = hexToColor('#4383D1');
  static Color darkWhite = hexToColor('#fefffe');
  static Color lightBlack = hexToColor('#1c2d36');
  static Color red = hexToColor('#ac1116');
  static Color green = hexToColor('#19ac11');
}
