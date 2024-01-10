import 'package:get/get.dart';

import 'logic.dart';

class ResetPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ResetPasswordLogic());
  }
}
