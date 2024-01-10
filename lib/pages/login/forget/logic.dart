import 'dart:async';

import 'package:get/get.dart';

import '../../../request/requests.dart';

class ForgetLogic extends GetxController {
  var phoneNumber = '';
  var idCode='';
  var definePhoneNumber = '';
  var defineCode='';

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
