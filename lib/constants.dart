import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:wowowwish/config/app_toast.dart';
import 'package:wowowwish/request/app_request.dart';
import 'package:wowowwish/request/requests.dart';
import 'package:wowowwish/routes/app_routes.dart';
import 'package:wowowwish/wish_counter_logic.dart';

import 'model/account.dart';

final box = GetStorage();
GetStorage boxAccount=GetStorage('MyAccount');
GetStorage boxFriend=GetStorage('MyFriend');
GetStorage boxFlag=GetStorage('Flag');
GetStorage boxReminder=GetStorage('Reminder');
// int colorIndex=0;

loginUpdateBox(Account accountMine, List myFriendsInfo){
  boxAccount.write(
    'username',
    accountMine.name,
  );
  boxAccount.write(
    'qualia_id',
    accountMine.qualiaId,
  );
  boxAccount.write(
    'token',
    accountMine.token,
  );
  boxAccount.write(
    'portrait',
    accountMine.portrait,
  );
  boxFriend.write(
    'them',
    myFriendsInfo,
  );
}
updateBox() async {
  var myFriendsInfo =await AppRequest().getFriends(boxAccount.read('user_uid'));
  boxFriend.write(
    'them',
    myFriendsInfo,
  );
  Map<String,int> friendUserIdMap={};
  for(var item in myFriendsInfo){
    if(item['user_uid']!=-1){
      friendUserIdMap[item['user_uid'].toString()]=item['relation_id'];
    }
  }
  boxAccount.write('friend_uid_map', friendUserIdMap);
}

updateWannaList(int userUid) async {
  var allWannaRes = await AppRequest().getAllWanna(userUid);
  var allWanna=allWannaRes['data'];
  var ongoingWannaRes = await AppRequest().getOngoingWanna(userUid);
  var ongoingWanna = ongoingWannaRes['data'];
  var doneWannaRes = await AppRequest().getDoneWanna(userUid);
  var doneWanna = doneWannaRes['data'];
  allWanna.sort(
        (a, b) => DateTime.parse(b['pub_date']).compareTo(
      DateTime.parse(a['pub_date']),
    ),
  );
  ongoingWanna.sort(
        (a, b) => DateTime.parse(b['pub_date']).compareTo(
      DateTime.parse(a['pub_date']),
    ),
  );
  doneWanna.sort(
        (a, b) => DateTime.parse(b['pub_date']).compareTo(
      DateTime.parse(a['pub_date']),
    ),
  );
  box.write('all_wanna', allWanna);
  box.write('ongoing_wanna', ongoingWanna);
  box.write('done_wanna', doneWanna);
}
bool isChinesePhoneNumber(String phoneNumber) {
  const pattern = r'^(13[0-9]|14[0-9]|15[0-9]|16[0-9]|17[0-9]|18[0-9]|19[0-9])[0-9]{8}$';
  final regExp = RegExp(pattern);
  return regExp.hasMatch(phoneNumber);
}

clearWishCount(){
  box.write('wishCount', 0);
  WishCounterLogic wishCounterLogic = Get.find<WishCounterLogic>();
  wishCounterLogic.wishCount.value=0;
}

tokenTest() async {
  WishCounterLogic wishCounterLogic = Get.find<WishCounterLogic>();
  if(boxAccount.hasData('token')==false){
    Get.offAllNamed(Routes.LOGIN,arguments: 'null');
  }else{
    Dio dioWithToken = AppRequestType().getDioWithToken(boxAccount.read('token'));
    var responseGetUserInfo = await dioWithToken
        .post('/users_query', data: {"query_type": 1, "key": boxAccount.read('account')});

    var result = responseGetUserInfo.data;
    if(result.runtimeType==''.runtimeType){
      String phoneNumber = boxAccount.read('account');
      String password = boxAccount.read('token');
      var response = await AppRequest().getTokenWithMethod('TOKEN', phoneNumber, password);
      if(response['code']=='000001'){
        boxAccount.write('token', response['data']['token']);
      }else{
        appShowToast('登录失效了，请重新登录');
        Get.offAllNamed(Routes.LOGIN, arguments: 'invalid');
      }
      // var responseGetToken = await AppRequest().getToken(boxAccount.read('account'), boxAccount.read('password'));
      // await boxAccount.write('token', responseGetToken['data']['token']);
    }else{
      if(result['notice']!=null){
        wishCounterLogic.wishCount.value = responseGetUserInfo.data['notice']['wish'];
        box.write('wishCount', wishCounterLogic.wishCount.value);
      }
    }

  }
}
