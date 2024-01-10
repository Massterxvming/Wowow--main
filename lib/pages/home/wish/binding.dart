import 'package:get/get.dart';

import 'logic.dart';

class WishBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WishLogic());
  }
}
