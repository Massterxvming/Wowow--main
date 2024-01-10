import 'dart:async';

import 'package:get/get.dart';
import 'package:wowowwish/config/app_toast.dart';
import 'package:wowowwish/request/requests.dart';

class SignUpLogic extends GetxController {
  String mobilePhone='';
  String password='';
  String repeatPassword='';
  String idCode='';
  var definePhoneNumber = '';
  var defineCode='';
  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }
  getVerifyCode() async {
    var code = await AppRequest().getVerifyCode(mobilePhone);
    defineCode=code;
    definePhoneNumber=mobilePhone;
    Timer.periodic(const Duration(minutes: 15), (timer) {
      defineCode='';
      definePhoneNumber='';
    });
    // print(code);
    var response = await AppRequest().sendSMS(mobilePhone, code);
  }
  Future<bool> isAlreadySignUp() async {
    var responseLogin = await AppRequest().getTokenWithMethod('SMS', mobilePhone, idCode);
    return responseLogin['code']=='000001';
  }
  void signUpButton()async{
    var response= await AppRequest().signUp(mobilePhone, password);
    if(response['code']=='000001'){
      appShowToast('注册成功');
      Get.back();
    }else if(response['code']=='000002'){
      appShowToast('该手机号已注册');
    }

  }
  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
