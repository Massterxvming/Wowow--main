import 'package:get/get.dart';

import 'logic.dart';

class WantBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WantLogic());
  }
}
