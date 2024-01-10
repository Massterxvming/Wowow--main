import 'package:get/get.dart';

import 'logic.dart';

class EditPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EditPasswordLogic());
  }
}
