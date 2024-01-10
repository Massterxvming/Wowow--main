import 'package:get/get.dart';

import 'logic.dart';

class WishListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WishListLogic());
  }
}
