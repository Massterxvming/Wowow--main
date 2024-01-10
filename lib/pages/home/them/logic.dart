import 'package:get/get.dart';
import 'package:wowowwish/constants.dart';
import 'package:wowowwish/model/them.dart';


class ThemLogic extends GetxController {
  late String token;
  late List themList;
  late List friendList;
  late int userUid;

  @override
  Future<void> onInit() async {
    userUid=boxAccount.read('user_uid');
    token=boxAccount.read('token');
    themList=await boxFriend.read('them');
    friendList=[MyThem.fromJson(themList[0]),MyThem.fromJson(themList[1]),MyThem.fromJson(themList[2])];
    super.onInit();
  }
  @override
  void onReady() async{
    await friendList[0].getNumbers(token,userUid);
    await friendList[0].getWanna(token,userUid);
    await friendList[1].getNumbers(token,userUid);
    await friendList[1].getWanna(token,userUid);
    await friendList[2].getNumbers(token,userUid);
    await friendList[2].getWanna(token,userUid);
    updateBox();
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
