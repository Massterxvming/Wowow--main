import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppStyle {
  static const boxDecoration = BoxDecoration(
    boxShadow: [
      BoxShadow(
        color: AppColors.shadowColor,
        blurRadius: 10,
        offset: Offset(0, 2),
        spreadRadius: 0,
      )
    ],
    color: AppColors.appBackground,
    borderRadius: BorderRadius.all(Radius.circular(6)),
  );
  static const shapeDecoration = ShapeDecoration(
    color: Color(0xFFE3E5DC),
    shape: RoundedRectangleBorder(
      side: BorderSide(width: 0.48, color: AppColors.borderSideColor),
      borderRadius: BorderRadius.all(Radius.circular(16)),
    ),
    shadows: [
      BoxShadow(
        color: AppColors.shadowColor,
        blurRadius: 10,
        offset: Offset(0, 2),
        spreadRadius: 0,
      )
    ],
  );
  static const btnShapeDecoration = ShapeDecoration(
    color: Color(0xFFE3E5DC),
    shape: RoundedRectangleBorder(
      side: BorderSide(width: 0.50, color: AppColors.borderSideColor),
      borderRadius: BorderRadius.all(Radius.circular(6)),
    ),
  );
  static const postItemBoxDecoration = BoxDecoration(
    boxShadow: [
      BoxShadow(
        color: AppColors.shadowColor,
        blurRadius: 10,
        offset: Offset(0, 2),
        spreadRadius: 0,
      )
    ],
    color: AppColors.appBackground,
    borderRadius: BorderRadius.all(
      Radius.circular(24),
    ),
  );

}

