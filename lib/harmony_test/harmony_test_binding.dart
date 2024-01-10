import 'package:get/get.dart';

import 'harmony_test_logic.dart';

class Harmony_testBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Harmony_testLogic());
  }
}
