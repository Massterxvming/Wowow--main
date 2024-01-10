import 'package:get/get.dart';

class ResetPasswordLogic extends GetxController {
  String password='';
  String repeatPassword='';
  final token = Get.arguments[0];//arguments接收
  final userUid = Get.arguments[1];
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
