import 'package:get/get.dart';

import 'logic.dart';

class EditUsernameBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EditUsernameLogic());
  }
}
