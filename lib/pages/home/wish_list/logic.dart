import 'package:get/get.dart';
import 'package:wowowwish/constants.dart';
import 'package:wowowwish/model/wish.dart';
import 'package:wowowwish/wish_counter_logic.dart';


class WishListLogic extends GetxController {
  List postList = [];
  List<Wish> friendWishList = <Wish>[];
  late WishCounterLogic wishCounterLogic ;
 
  @override
  void onInit() {
    print(boxAccount.read('token'));
  wishCounterLogic = Get.find<WishCounterLogic>();
    // TODO: implement onInit
    super.onInit();
  }
  @override
  Future<void> onReady() async {
    // updateBox();
    // postList = await box.read('post');
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
