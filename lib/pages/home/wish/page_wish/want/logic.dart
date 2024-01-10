import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:wowowwish/config/app_toast.dart';
import 'package:wowowwish/constants.dart';
import 'package:wowowwish/model/wanna.dart';
import 'package:wowowwish/request/app_request.dart';
import 'package:wowowwish/request/requests.dart';

import '../../../../../styles/app_colors.dart';
import '../../../../../styles/app_style.dart';

class WantLogic extends GetxController {
  var wantContent='';
  late String? picUrl="";
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

  void saveContent(value) {
    wantContent=value;
  }

  Future<void> onSend() async{
    picUrl=picUrl ?? '';
    if(wantContent!=''){
      var response = await AppRequest()
          .sendWanna(Wanna(boxAccount.read('user_uid'), wantContent, picUrl!));
      if (response['code'] == '000001') {
        appShowToast('添加成功');
        updateWannaList(boxAccount.read('user_uid'));
        Get.back();
      }
    }else{
      appShowToast('想要内容不能为空');
    }
    Get.back();
  }
}
