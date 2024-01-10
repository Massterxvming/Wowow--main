import 'package:get/get.dart';

import 'logic.dart';

class UserBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UserLogic());
  }
}
