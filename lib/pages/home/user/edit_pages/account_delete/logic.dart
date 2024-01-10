import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:wowowwish/config/app_strings.dart';
import 'package:wowowwish/config/app_toast.dart';
import 'package:wowowwish/request/app_request.dart';

import '../../../../../constants.dart';
import '../../../../../routes/app_routes.dart';
import '../../../../../styles/app_colors.dart';
import '../../../../../styles/app_style.dart';

class AccountDeleteLogic extends GetxController {
  RxBool isLoading = false.obs;
  void showLoading() {
    isLoading.value = true;
    Get.dialog(
        Center(
          child: Container(
              height: 100,
              width: 100,
              decoration: AppStyle.shapeDecoration,
              child: const Padding(
                padding: EdgeInsets.all(26.0),
                child: CircularProgressIndicator(color: AppColors.bottomNvAndLoading,),
              )),
        ),
        barrierDismissible: false);
  }

  void hideLoading() {
    isLoading.value = false;
  }
  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
