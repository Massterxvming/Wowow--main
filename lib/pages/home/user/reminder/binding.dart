import 'package:get/get.dart';

import 'logic.dart';

class ReminderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ReminderLogic());
  }
}
