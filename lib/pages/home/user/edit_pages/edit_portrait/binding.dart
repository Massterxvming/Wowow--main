import 'package:get/get.dart';

import 'logic.dart';

class EditPortraitBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EditPortraitLogic());
  }
}
