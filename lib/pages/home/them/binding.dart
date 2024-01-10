import 'package:get/get.dart';

import 'logic.dart';

class ThemBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ThemLogic());
  }
}
