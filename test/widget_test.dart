// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wowowwish/app.dart';

void main() {
  final List<Color> colors = [
    Color(0xff9ab73b),
    Color(0xFFFFFFFF),
    Color(0xFFB8BEA8),
    Color(0xFFCFD5BD),
    Color(0xff9CC300),
    Color(0xFF161616),
    Color(0xFF96AA6D),
    Color(0xFF91A443),
    Color(0xFF8B907A),
    Color(0xFFCCD2B7),
    Color(0xff232323),
    Color(0xff000000),
    Color(0xffFFFFFF),
    Color(0xFFD3D7C8).withOpacity(0.6),
    Color(0xFFE3E5DC),
    Color(0xFFE0E0E0),
    Color(0xFF232323),
    Color(0xFFBDF324),
    Color(0x19000000),
    Color(0xFF2D2D2D),
    Color(0xFF606356),
    Color(0xFFD1D5A1),
    Color(0xFF888D78),
    Color(0xFF97AA6E),
    Colors.black.withOpacity(0.25),
  ];

  Set<Color> uniqueColors = Set<Color>();
  List<Color> duplicateColors = [];

  for (var color in colors) {
    if (!uniqueColors.add(color)) {
      duplicateColors.add(color);
    }
  }

  if (duplicateColors.isEmpty) {
    print("没有重复的颜色");
  } else {
    print("以下颜色是重复的:");
    duplicateColors.forEach((color) {
      print(color);
    });
  }
}
