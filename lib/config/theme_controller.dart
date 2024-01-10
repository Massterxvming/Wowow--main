import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:wowowwish/constants.dart';
import 'package:wowowwish/styles/app_colors.dart';
class ThemeController extends GetxController{
  // var selectedThemeIndex = colorIndex;

  static ThemeData baseThemeData = ThemeData(
      useMaterial3: true,
    // fontFamily: 'NotoSansSc',
  );
  final List<ThemeData> themes = [//颜色配置
    baseThemeData.copyWith(
      brightness: Brightness.dark,
      colorScheme:AppColors.lightGreenScheme,
    )
  ];
}