import 'package:get/get.dart';

import '../../../config/app_toast.dart';
import '../../../constants.dart';
import '../../../model/account.dart';
import '../../../request/requests.dart';
import '../../../routes/app_routes.dart';

class SetPasswordLogic extends GetxController {
  String password='';
  String repeatPassword='';
  late final String phoneNumber;
  signUpButton()async{
    var response= await AppRequest().signUp(phoneNumber, password);
    if(response['code']=='000001'){
      appShowToast('注册成功');
      Get.back();
    }else if(response['code']=='000002'){
      appShowToast('该手机号已注册');
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

  @override
  void onInit() {
    phoneNumber=Get.arguments;
    // TODO: implement onInit
    super.onInit();
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
