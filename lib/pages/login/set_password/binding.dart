import 'package:get/get.dart';

import 'logic.dart';

class SetPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SetPasswordLogic());
  }
}
