import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:wowowwish/config/app_toast.dart';
import 'package:wowowwish/constants.dart';
import 'package:wowowwish/pages/home/user/logic.dart';
import 'package:wowowwish/request/app_request.dart';

import '../../../../../styles/app_colors.dart';
import '../../../../../styles/app_style.dart';

class EditPasswordLogic extends GetxController {
  String password='';
  String repeatPassword='';
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
  onConfirm() async{
    showLoading();
      var dio=AppRequestType().getDioWithToken(boxAccount.read('token'));
      var response = await dio.put('/users',data: {
        "user_uid":boxAccount.read('user_uid'),
        "edit_param":2,
        "password":password
      });
      if(response.data['code']=='000001'){
        appShowToast('修改成功');
        Get.back();
      }else{
        appShowToast('未知错误，修改失败');
      }
    hideLoading();
    Get.back();
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
