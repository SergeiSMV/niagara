import 'package:flutter/material.dart';

extension HexColor on Color {
  static Color fromHex(String hexString) {
    if (hexString.isEmpty) return Colors.transparent;

    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  static String toHex(Color color) {
    if (color == Colors.transparent) return '';
    return '#${color.value.toRadixString(16).substring(2)}';
  }
}
