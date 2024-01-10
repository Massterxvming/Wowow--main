import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wowowwish/config/app_toast.dart';
import 'package:wowowwish/constants.dart';
import 'package:wowowwish/model/wish.dart';
import 'package:wowowwish/request/requests.dart';
import 'package:wowowwish/routes/app_routes.dart';
import '../../../components/widgets/app_text_field.dart';
import '../../../config/app_strings.dart';
import '../../../model/them.dart';
import '../../../styles/app_colors.dart';
import '../../../styles/app_style.dart';

class AddFriendLogic extends GetxController {
  late var relation = '';
  var shareContent = '';
  late int myUId ;
  late var relationInTitle = ''.obs;
  var addPhone = '';
  late String postValue;
  List<int> myFriendUidList=[];
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
                child: CircularProgressIndicator(
                  color: AppColors.bottomNvAndLoading,
                ),
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
    }
  };
  @override
  void onReady() {//刷新三个好友的界面
    myUId=Get.arguments[0];
    relation = Get.arguments[1];
    relationInTitle.value = map[relation]['string'];
    postValue = map[relation]['postValue'];
    myFriendUidList.add(boxFriend.read('them')[0]['user_uid']);
    myFriendUidList.add(boxFriend.read('them')[1]['user_uid']);
    myFriendUidList.add(boxFriend.read('them')[2]['user_uid']);
    update();

    // TODO: implement onReady
    super.onReady();
  }

  getAddPhone(value) {
    addPhone = value;
  }

  onConfirm() async {
    var responseGetUser = await AppRequest().getAccountInfo(addPhone);
    var blockUserIdList = await AppRequest().queryBlockListUserIdList();
    if (responseGetUser['data'].isNotEmpty) {
      Map addUserJson = responseGetUser['data'][0];
      if(addUserJson['user_uid']==boxAccount.read('user_uid')){
        appShowToast('您不能添加自己为好友');
        Get.back();
      }else if(myFriendUidList.contains(addUserJson['user_uid'])){
        appShowToast('您不能重复添加好友');
        Get.back();
      }else if(blockUserIdList.contains(addUserJson['user_uid'])){
        Get.back();
        appShowToast('您已将对方拉黑，请先将Ta从黑名单中移出吧');
      }else{
        addUserJson['relation'] = relation;
        MyThem myThem = MyThem.fromJson(addUserJson);
        var response =
            await AppRequest().addFriend(myUId, myThem.userUid, relation);
        if (response['code'] == '000001') {
          var test = await AppRequest().getFriends(boxAccount.read('user_uid'));
          boxFriend.write('them', test);
          appShowToast('添加成功');
          Get.offNamed(Routes.HOME);
        } else {
          appShowToast('添加失败，请稍后重试');
          Get.back();
        }
      }
    } else {
      Get.back();
      showDialog<void>(
        context: Get.context!,
        barrierDismissible: true,
        // false = user must tap button, true = tap outside dialog
        builder: (BuildContext dialogContext) {
          return AlertDialog(
            title: const Icon(
              Icons.sentiment_dissatisfied_sharp,
              size: 40,
            ),
            content: const Text(
              '不好！我们没有找到Ta...\n但你可以许一个愿望让Ta来一起玩',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            actions: <Widget>[
            TextField(
            maxLength: 40,
            onChanged: (val){
              shareContent=val;
            },
            decoration: InputDecoration(
              counterText: '',
              hintText: '请输入您的愿望',
              labelText: '您的愿望',
              labelStyle: const TextStyle(
                color: AppColors.black,
              ),
              border:  const OutlineInputBorder(),
              enabledBorder:  const OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.appBackground,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(12),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide:  const BorderSide(
                  color: AppColors.appBackground,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              floatingLabelStyle:  const TextStyle(color: AppColors.floatingLabelTextColor),
              filled: true,
              fillColor: AppColors.appBackground,
            ),
          ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    child: const SizedBox(
                      width: 57,
                      height: 20,
                      child: Text(
                        AppStrings.cancel,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.secondary,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          height: 1.50,
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(dialogContext).pop(); // Dismiss alert dialog
                    },
                  ),
                  TextButton(
                    child: const SizedBox(
                      width: 57,
                      height: 20,
                      child: Text(
                        AppStrings.confirm,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.secondary,
                          fontSize: 14,

                          fontWeight: FontWeight.w400,
                          height: 1.50,
                        ),
                      ),
                    ),
                    onPressed: (){
                      Wish wish=Wish(0, 0, '', '', 0, shareContent, '', '', '', '', '', '');
                      Get.back();
                      Get.back();
                      Get.toNamed(Routes.WISHSHARESIMPLE,arguments: wish.toMap());
                    },
                  ),
                ],
              ),
            ],
          );
        },
      );
    }
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
