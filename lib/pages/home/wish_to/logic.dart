import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:wowowwish/components/widgets/app_text_field.dart';
import 'package:wowowwish/config/app_toast.dart';
import 'package:wowowwish/constants.dart';
import 'package:wowowwish/request/requests.dart';
import 'package:wowowwish/routes/app_routes.dart';

import '../../../config/app_strings.dart';
import '../../../styles/app_colors.dart';
import '../../../styles/app_style.dart';

class WishToLogic extends GetxController {
  var wishContent = '';
  late String? picUrl;

  late int postToUid;
  late int posterUid;
  late var postTitle = ''.obs;
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

  static const Map map = {
    'realMe': {'color': Color(0xFF000000), 'string': AppStrings.realMe},
    'lover': {
      'color': Color(0xFFFA7AE2),
      'string': AppStrings.lover,
      'postValue': 'lover'
    },
    'friend': {
      'color': Color(0xFF54D2F6),
      'string': AppStrings.friend,
      'postValue': 'friend'
    },
    'gene': {
      'color': Color(0xFF29DE45),
      'string': AppStrings.gene,
      'postValue': 'gene'
    },
    'tree': {'string': '神树', 'postValue': 'tree'}
  };
  @override
  Future<void> onReady() async {
    print(Get.arguments[0]);
    postTitle.value = map[Get.arguments[0]]['string'];
    postToUid = Get.arguments[1]['post_to_uid'];
    posterUid = Get.arguments[1]['poster_uid'];
    update();
    super.onReady();
  }

  saveContent(value) {
    wishContent = value;
  }

  onSend() async {
    if(wishContent!=''){
      var response = await AppRequest()
          .sendWish(posterUid, postToUid, picUrl, wishContent);
      if (response['code'] == '000001') {
        var test = await AppRequest().getFriends(posterUid);
        boxFriend.write('them', test);
        appShowToast('许愿成功');
        Get.offAllNamed(Routes.HOME);
      } else {
        appShowToast('许愿失败，请检查网络或稍后重试。');
        Get.back();
      }
    }else{
      appShowToast('愿望内容不能为空');
      Get.back();
    }
  }

  @override
  void onClose() {

    // TODO: implement onClose
    super.onClose();
  }
}

