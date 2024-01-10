import 'package:get/get.dart';

import 'logic.dart';

class TermsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TermsLogic());
  }
}
