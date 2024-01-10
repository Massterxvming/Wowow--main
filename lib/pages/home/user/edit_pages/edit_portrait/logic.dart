import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wowowwish/constants.dart';

import '../../../../../styles/app_colors.dart';
import '../../../../../styles/app_style.dart';

class EditPortraitLogic extends GetxController {
  String? picUrl='';
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
  void onInit() {
    picUrl=boxAccount.read('portrait');

    // TODO: implement onInit
    super.onInit();
  }
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
