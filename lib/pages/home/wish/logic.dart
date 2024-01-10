import 'package:get/get.dart';
import 'package:wowowwish/constants.dart';
import 'package:wowowwish/model/account.dart';
import 'package:wowowwish/model/reminder_simple.dart';
enum Them {
  gene,
  lover,
  friend,
}

class WishLogic extends GetxController {
  List friendList=[];
  late String token;
  late Account account;
  late RxList myWishCardList=[[],[],[]].obs;
  static List list=['gene','lover','friend'];
  late List<SimpleReminder> reminderList;
  @override
  void onInit()  {
    reminderList=[];
    account=Account(boxAccount.read('user_uid'), boxAccount.read('account'), boxAccount.read('password'), boxAccount.read('qualia_id'), boxAccount.read('username'), boxAccount.read('portrait'), boxAccount.read('token'));
    token=boxAccount.read('token');
    super.onInit();
  }
  onUpdate() async {
    friendList= await boxFriend.read('them');
    var count=0;
    for(var item in friendList){
      if(item['wish_list_to_them']==null){
        myWishCardList[count]=[];
      }else{
        myWishCardList[count]=item['wish_list_to_them'];
      }
      count++;
    }
  }
  @override
  void onReady() {
    update();
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
