import 'package:get/get.dart';
import 'package:wowowwish/config/app_strings.dart';
import '../../../constants.dart';
import '../../../model/account.dart';
import '../../../routes/app_routes.dart';

class UserLogic extends GetxController {
  late Rx<Account> account;
  late RxString pic=''.obs;
  Map pageListUser() {
    return {
      AppStrings.want: () {
        Get.toNamed(Routes.WANNALIST);
      },
      AppStrings.markDate:(){
        Get.toNamed(Routes.REMINDER);
      },
      AppStrings.todoList: () {
        //Todo: 进入Todo页面
        print('Click:todo');
      },
      AppStrings.nftGuide: () {
        //Todo: 进入NFT页面
        print('Click:nft');
      },
      AppStrings.editUsername: () async {
        Get.toNamed(Routes.EDITUSERNAME);
        print('Click:editUsername');
      },
      AppStrings.editPassword: () {
        Get.toNamed(Routes.EDITPASSWORD);
        print('Click:editPassword');
      },
      "黑名单":(){
        Get.toNamed(Routes.BLOCKUSERLIST);
      },
      AppStrings.setting: () {
        Get.toNamed(Routes.SETTING);
      },
      AppStrings.privacy: () {
        Get.toNamed(Routes.PRIVACY);
      },
      AppStrings.accountDelete: () {
        Get.toNamed(Routes.ACCOUNTDELETE);
      },
      '条款与条件':(){
        Get.toNamed(Routes.TERMS);
      }
    };
  }

  final List nameList_1 = [
    AppStrings.want,
    AppStrings.markDate
  ];
  final List nameList_2 = [
    AppStrings.editUsername,
    AppStrings.editPassword,
    "黑名单",
    AppStrings.accountDelete,
  ];
  final List nameList_3 = [
    AppStrings.setting,
    AppStrings.privacy,
    '条款与条件'
  ];
updateUsername() async {
  account.value.name=await boxAccount.read('username');
  account.refresh();
}
updatePortrait() async {
    account.value.portrait!=await boxAccount.read('portrait');
    account.refresh();
  }

  @override
  void onInit() {
    if(boxAccount.read('portrait')!=null){
      pic.value=boxAccount.read('portrait');
    }

    account = Account(
        boxAccount.read('user_uid'),
        boxAccount.read('account'),
        boxAccount.read('password'),
        boxAccount.read('qualia_id'),
        boxAccount.read('username'),
        boxAccount.read('portrait'),
        boxAccount.read('token')).obs;
    account.refresh();

    super.onInit();
  }

  @override
  void onReady() {
    updateBox();
    update();
    super.onReady();
  }
  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
