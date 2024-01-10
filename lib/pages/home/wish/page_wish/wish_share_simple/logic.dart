import 'dart:math';
import 'dart:ui';

import 'package:get/get.dart';

import '../../../../../model/wish.dart';

class WishShareSimpleLogic extends GetxController {
  late Wish wish;
  final random = Random();
  late int r=0;
  late int g=0;
  late int b=0;
  late Color backgroundColor;
  @override
  void onInit() {
    wish=Wish.fromJson(Get.arguments);
    r = random.nextInt(256);
    g = random.nextInt(256);
    b = random.nextInt(256);
    if(r+g+b==0){
      r = random.nextInt(256);
      g = random.nextInt(256);
      b = random.nextInt(256);
    }
    backgroundColor=Color.fromRGBO(r, g, b, 1.0);
    // TODO: implement onInit
    super.onInit();
  }
  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
