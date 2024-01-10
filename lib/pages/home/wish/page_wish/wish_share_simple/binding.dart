import 'package:get/get.dart';

import 'logic.dart';

class WishShareSimpleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WishShareSimpleLogic());
  }
}
