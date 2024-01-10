import 'package:get/get.dart';

class DeletePostListLogic extends GetxController {
  late var savedeleteList=[];
  @override
  void onReady() {
    savedeleteList=Get.arguments['deletePost'];
    print(savedeleteList);
    update();
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
