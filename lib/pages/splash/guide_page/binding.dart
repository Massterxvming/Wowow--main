import 'package:get/get.dart';

import 'logic.dart';

class GuidePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GuidePageLogic());
  }
}
