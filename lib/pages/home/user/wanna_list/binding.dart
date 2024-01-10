import 'package:get/get.dart';

import 'logic.dart';

class WannaListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WannaListLogic());
  }
}
