import 'package:get/get.dart';

import 'logic.dart';

class AddFriendBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddFriendLogic());
  }
}
