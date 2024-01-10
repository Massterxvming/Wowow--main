import 'package:get/get.dart';

import 'logic.dart';

class WishToBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WishToLogic());
  }
}
