import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:wowowwish/config/app_toast.dart';
import 'package:wowowwish/constants.dart';
import 'package:wowowwish/request/requests.dart';

import '../../../../../request/app_request.dart';
import '../../../../../styles/app_colors.dart';
import '../../../../../styles/app_style.dart';
import '../../logic.dart';

class EditUsernameLogic extends GetxController {
  var username = '';
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
  onConfirm() async {
    if(username!=boxAccount.read('username')){
      var response = await AppRequest().editUsername(username);
      if (response['code'] == '000001') {
        appShowToast('修改成功');
        await boxAccount.write('username', username);
        Get.back();
        var logicSuper = Get.find<UserLogic>();
        logicSuper.updateUsername();
      }
    }else{
      appShowToast('您未作出任何更改');
    }
    Get.back();
  }
@override
  void onInit() {
    username=boxAccount.read('username');
    // TODO: implement onInit
    super.onInit();
  }
  @override
  void onReady() {
    update();
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
