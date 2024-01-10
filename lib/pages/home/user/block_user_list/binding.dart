import 'package:get/get.dart';

import 'logic.dart';

class BlockUserListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BlockUserListLogic());
  }
}
