import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:wowowwish/request/app_request.dart';
import 'constants.dart';

class WishCounterLogic extends GetxController{

  RxInt wishCount = 0.obs;

  @override
  Future<void> onReady() async {
    Dio dioWithToken = AppRequestType().getDioWithToken(boxAccount.read('token'));
    var responseGetUserInfo = await dioWithToken
        .post('/users_query', data: {"query_type": 1, "key": boxAccount.read('account')});
    if(box.hasData('wishCount')){
      wishCount.value=box.read('wishCount');
    }
    if(responseGetUserInfo.data['notice']!=null){
      wishCount.value = responseGetUserInfo.data['notice']['wish'];
    }
    // TODO: implement onReady
    super.onReady();
  }
}