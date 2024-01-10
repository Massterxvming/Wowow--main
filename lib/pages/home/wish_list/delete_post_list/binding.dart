import 'package:get/get.dart';

import 'logic.dart';

class DeletePostListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DeletePostListLogic());
  }
}
