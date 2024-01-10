import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wowowwish/config/app_toast.dart';
import 'package:wowowwish/model/account.dart';
import 'package:wowowwish/request/requests.dart';
import 'package:wowowwish/routes/app_routes.dart';
import 'package:wowowwish/styles/app_colors.dart';
import 'package:wowowwish/styles/app_style.dart';
import '../../constants.dart';

class LoginLogic extends GetxController {
  var phoneNumber = '';
  var definePhoneNumber = '';
  var password = '';
  var idCode='';
  var defineCode='';
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

  getVerifyCode() async {
      var code = await AppRequest().getVerifyCode(phoneNumber);
      defineCode=code;
      definePhoneNumber=phoneNumber;
      Timer.periodic(const Duration(minutes: 15), (timer) {
        defineCode='';
        definePhoneNumber='';
      });
      // print(code);
      var response = await AppRequest().sendSMS(phoneNumber, code);
  }
  doLoginWithVerifyCode() async {
    var responseLogin = await AppRequest().getTokenWithMethod('SMS', phoneNumber, idCode);
    print(responseLogin);
    if (responseLogin['code'] == '000001') {
      String token = responseLogin['data']['token'];
      boxAccount.write(
        'token',
        token,
      );
      var responseGetUserInfo =
      await AppRequest().getAccountInfo(phoneNumber);
      Map accountMap = responseGetUserInfo['data'][0];
      accountMap['token'] = token;
      Account accountMine = Account.fromJson(accountMap);
      boxAccount.write(
        'account',
        accountMine.mobilePhone,
      );

      boxAccount.write(
        'user_uid',
        accountMine.userUid,
      );
      List myFriendsInfo =
      await AppRequest().getFriends(accountMine.userUid);
      updateWannaList(accountMine.userUid);
      loginUpdateBox(accountMine, myFriendsInfo);
      int userUid=boxAccount.read('user_uid');
      List myFriendsWishTo =
      await AppRequest().getFriendsWishToList(userUid);
      await boxFriend.write(
        'wish_to',
        myFriendsWishTo,
      );
      appShowToast('登录成功');
      Map<String,int> friendUserIdMap={};
      for(var item in myFriendsInfo){
        if(item['user_uid']!=-1){
          friendUserIdMap[item['user_uid'].toString()]=item['relation_id'];
        }
      }
      boxAccount.write('friend_uid_map', friendUserIdMap);
      Get.offAllNamed(Routes.HOME);
    } else if (responseLogin['code'] == '000002') {
      // appShowToast('手机号或验证码无效');
      Get.back();
      if(defineCode==idCode&&definePhoneNumber==phoneNumber){
        Get.toNamed(Routes.SETPASSWORD, arguments: phoneNumber);
      }else{
        appShowToast('手机号或验证码无效');
      }
    }
  }
  Future<void> doLogin() async {
    var responseLogin = await AppRequest().getToken(phoneNumber, password);
    if (responseLogin['code'] == '000001') {
      String token = responseLogin['data']['token'];
      boxAccount.write(
        'token',
        token,
      );
      var responseGetUserInfo =
          await AppRequest().getAccountInfo(phoneNumber);
      Map accountMap = responseGetUserInfo['data'][0];
      accountMap['password'] = password;
      accountMap['token'] = token;
      Account accountMine = Account.fromJson(accountMap);
      boxAccount.write(
        'account',
        accountMine.mobilePhone,
      );
      boxAccount.write(
        'password',
        accountMine.password,
      );
      boxAccount.write(
        'user_uid',
        accountMine.userUid,
      );
      List myFriendsInfo =
          await AppRequest().getFriends(accountMine.userUid);
      updateWannaList(accountMine.userUid);
      loginUpdateBox(accountMine, myFriendsInfo);
      int userUid=boxAccount.read('user_uid');
      List myFriendsWishTo =
      await AppRequest().getFriendsWishToList(userUid);
      await boxFriend.write(
        'wish_to',
        myFriendsWishTo,
      );
      appShowToast('登录成功');
      Map<String,int> friendUserIdMap={};
      for(var item in myFriendsInfo){
        if(item['user_uid']!=-1){
          friendUserIdMap[item['user_uid'].toString()]=item['relation_id'];
        }
      }
      boxAccount.write('friend_uid_map', friendUserIdMap);
      Get.offAllNamed(Routes.HOME);
    } else if (responseLogin['code'] == '000002') {
      appShowToast('账号或密码错误');
      Get.back();
    }
  }

  void doSignUp() {
    Get.toNamed(Routes.SIGNUP);
  }

  @override
  Future<void> onReady() async {
    Dio dio=Dio();
    var response =await dio.get('https://dart.dev');
    print(response.data);
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
