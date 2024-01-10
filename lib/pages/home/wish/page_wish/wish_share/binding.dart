import 'package:get/get.dart';

import 'logic.dart';

class WishShareBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WishShareLogic());
  }
}
