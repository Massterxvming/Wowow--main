import 'package:dio/dio.dart';
import 'package:get/get.dart'hide FormData,MultipartFile;
import 'package:wowowwish/config/app_toast.dart';
import 'package:wowowwish/constants.dart';
import 'package:wowowwish/model/wish.dart';
import 'package:wowowwish/wish_counter_logic.dart';
import '../model/block.dart';
import '../model/them.dart';
import '../model/wanna.dart';
import 'app_request.dart';

class AppRequest {
  WishCounterLogic wishCounterLogic = Get.find<WishCounterLogic>();
  getVerifyCode(String mobilePhone) async {
    Dio dio =AppRequestType().getDio();
    var response = await dio.post('/users/verifycode',data: {
      "mobile_phone":mobilePhone
    });
    return response.data['data']['code'];
  }


  getUserInfo(int userUid) async {
    await tokenTest();
    var myUid = boxAccount.read('user_uid');
    Dio dio = AppRequestType().getDioWithToken(boxAccount.read('token'));//访问用户数据
    var response = await dio.get('/users?user_uid=$myUid&target_uid=$userUid');
    MyThem myThem = MyThem(relation: '');
    myThem.username = response.data['data']['name'];
    myThem.portrait = response.data['data']['portrait'];
    myThem.qualiaId = response.data['data']['qualia_id'];
    myThem.mobilePhone = response.data['data']['mobile_phone'];
    var responseGetNum =
        await dio.get('/wishes_num?user_uid=$myUid&target_uid=$userUid');
    var numMap = responseGetNum.data['data'];
    myThem.numMyWishTo = numMap['to_target_all'];
    myThem.numMyWishThemDone = numMap['to_target_acpt'];
    myThem.numTheirWishToMe = numMap['from_target_all'];
    myThem.numTheirWishMeDone = numMap['from_target_acpt'];
    var responseAllWanna = await getAllWanna(userUid);
    myThem.wannaList = responseAllWanna['data'];
    return myThem;
  }

  getFriendsWishToList(userUid)async{
    await tokenTest();
    Dio dio = AppRequestType().getDioWithToken(boxAccount.read('token'));
    var response =
    await dio.get('/users/relations?user_uid=$userUid&target_uid=$userUid');
    List listTr = response.data['data'];
    List myFriends = [
      MyThem(relation: 'gene'),
      MyThem(relation: 'lover'),
      MyThem(relation: 'friend')
    ];
    for (Map item in listTr) {
      if (item['relation'] == 'gene') {
        myFriends[0].userUid = item['object_useruid'];
        myFriends[0].relationId = item['uid'];
      } else if (item['relation'] == 'lover') {
        myFriends[1].userUid = item['object_useruid'];
        myFriends[1].relationId = item['uid'];
      } else {
        myFriends[2].userUid = item['object_useruid'];
        myFriends[2].relationId = item['uid'];
      }
    }
    for (var i = 0; i < 3; i++) {
      if (myFriends[i].userUid != -1) {
        var response_1 = await dio
            .get('/users?user_uid=$userUid&target_uid=${myFriends[i].userUid}');
        myFriends[i].username = response_1.data['data']['name'];
        myFriends[i].portrait = response_1.data['data']['portrait'];
        myFriends[i].qualiaId = response_1.data['data']['qualia_id'];
        myFriends[i].mobilePhone = response_1.data['data']['mobile_phone'];
        await myFriends[i].getWishTo(boxAccount.read('token'), userUid);
      }
    }
    var myFriendsInfo = [
      myFriends[0].toMap(),
      myFriends[1].toMap(),
      myFriends[2].toMap()
    ];
    if (myFriendsInfo[0]['wish_list_to_them'] != null) {
      myFriendsInfo[0]['wish_list_to_them'].sort(
            (a, b) => DateTime.parse(b['pub_date']).compareTo(
          DateTime.parse(a['pub_date']),
        ),
      );
    }
    if (myFriendsInfo[1]['wish_list_to_them'] != null) {
      myFriendsInfo[1]['wish_list_to_them'].sort(
            (a, b) => DateTime.parse(b['pub_date']).compareTo(
          DateTime.parse(a['pub_date']),
        ),
      );
    }
    if (myFriendsInfo[2]['wish_list_to_them'] != null) {
      myFriendsInfo[2]['wish_list_to_them'].sort(
            (a, b) => DateTime.parse(b['pub_date']).compareTo(
          DateTime.parse(a['pub_date']),
        ),
      );
    }
    return myFriendsInfo;
  }

  Future<List> getFriends(userUid) async {
    await tokenTest();
    Dio dio = AppRequestType().getDioWithToken(boxAccount.read('token'));
    var response =
        await dio.get('/users/relations?user_uid=$userUid&target_uid=$userUid');
    List listTr = response.data['data'];
    List myFriends = [
      MyThem(relation: 'gene'),
      MyThem(relation: 'lover'),
      MyThem(relation: 'friend')
    ];
    for (Map item in listTr) {
      if (item['relation'] == 'gene') {
        myFriends[0].userUid = item['object_useruid'];
        myFriends[0].relationId = item['uid'];
      } else if (item['relation'] == 'lover') {
        myFriends[1].userUid = item['object_useruid'];
        myFriends[1].relationId = item['uid'];
      } else {
        myFriends[2].userUid = item['object_useruid'];
        myFriends[2].relationId = item['uid'];
      }
    }

    for (var i = 0; i < 3; i++) {
      if (myFriends[i].userUid != -1) {
        var response_1 = await dio
            .get('/users?user_uid=$userUid&target_uid=${myFriends[i].userUid}');
        myFriends[i].username = response_1.data['data']['name'];
        myFriends[i].portrait = response_1.data['data']['portrait'];
        myFriends[i].qualiaId = response_1.data['data']['qualia_id'];
        myFriends[i].mobilePhone = response_1.data['data']['mobile_phone'];
        await myFriends[i].getWanna(boxAccount.read('token'), userUid);
        await myFriends[i].getNumbers(boxAccount.read('token'), userUid);
      }
    }

    var myFriendsInfo = [
      myFriends[0].toMap(),
      myFriends[1].toMap(),
      myFriends[2].toMap()
    ];

    return myFriendsInfo;
  }

  getReminder(int userUid) async {
    await tokenTest();
    Dio dioWithToken =
        AppRequestType().getDioWithToken(boxAccount.read('token'));
    var response = await dioWithToken.get('/reminders?user_uid=$userUid');
    return response.data;
  }

  delReminder(int reminderId) async {
    await tokenTest();
    Dio dioWithToken =
        AppRequestType().getDioWithToken(boxAccount.read('token'));
    var response =
        await dioWithToken.delete('/reminders?reminder_uid=$reminderId');
    return response.data;
  }

  addReminder(int userUid, String dateTime, String text) async {
    await tokenTest();
    Dio dioWithToken =
        AppRequestType().getDioWithToken(boxAccount.read('token'));
    var response = await dioWithToken.post('/reminders',
        data: {"operator_uid": userUid, "date": dateTime, "description": text});
    return response.data;
  }

  sendSMS(String phoneNumber,String code) async {
    try{
      Dio getCodeDio = AppRequestType().getDioCodeGet();

      var response = await getCodeDio.post('', data: {
        "to": phoneNumber,
        "signature": "WoWoW许愿啦",
        "templateId": "pub_verif_ttl3",
        "templateData": {"code": code,"ttl":"2"}
      });
      print(response.data);
      return response.data;
    }catch(e){
      print(e);
      appShowToast('操作频繁，请稍后再试');
    }

  }

  getWishesToMe(int userUid) async {
    await tokenTest();
    Dio dioWithToken =
        AppRequestType().getDioWithToken(boxAccount.read('token'));
    var response = await dioWithToken.post('/wishes_query',
        data: {"user_uid": userUid, "object_uid": userUid});
    return response.data;
  }

  getUserByUid(int uid) async {
    await tokenTest();
    int userUid = await boxAccount.read('user_uid');
    Dio dio = AppRequestType().getDioWithToken(boxAccount.read('token'));
    var response = await dio.get('/users?user_uid=$userUid&target_uid=$uid');
    return {
      'username': response.data['data']['name'],
      'portrait': response.data['data']['portrait']
    };
  }

  getReceiverList(List postList) async {
    Dio dio = AppRequestType().getDioWithToken(boxAccount.read('token'));
    int userUid = await boxAccount.read('user_uid');
    List combinedList = [];
    for (var item in postList) {
      var response = await dio.get(
          '/users?user_uid=$userUid&target_uid=${item['subject_useruid']}');
      item['username'] = response.data['data']['name'];
      item['portrait'] = response.data['data']['portrait'];
      combinedList.add(item);
    }
    combinedList.sort(
      (a, b) => DateTime.parse(b['pub_date']).compareTo(
        DateTime.parse(a['pub_date']),
      ),
    );
    return combinedList;
  }

  getTokenWithMethod(String method,String phoneNumber, String password)async {
    Dio dio = AppRequestType().getDio();
    var responseLogin = await dio.post('/users/login',
        data: {
          "method":method,
          "mobile_phone": phoneNumber,
          "password": password});
    return responseLogin.data;
  }

  getToken(String phoneNumber, String password) async {
    Dio dio = AppRequestType().getDio();
    var responseLogin = await dio.post('/users/login',
        data: {
      "method":"ACCOUNT",
      "mobile_phone": phoneNumber,
          "password": password});
    return responseLogin.data;
  }

  getAccountInfo(String phoneNumber) async {
    Dio dioWithToken =
        AppRequestType().getDioWithToken(boxAccount.read('token'));
    var responseGetUserInfo = await dioWithToken
        .post('/users_query', data: {"query_type": 1, "key": phoneNumber});
    return responseGetUserInfo.data;
  }

  getAccountUid(String phoneNumber,String token) async {
    Dio dioWithToken =
    AppRequestType().getDioWithToken(token);
    var responseGetUserInfo = await dioWithToken
        .post('/users_query', data: {"query_type": 1, "key": phoneNumber});
    return responseGetUserInfo.data['data'][0]['user_uid'];
  }

  uploadImage(int posterUid, String? picUrl) async {
    await tokenTest();
    Dio dio = AppRequestType().getDioWithToken(boxAccount.read('token'));
    var saveImg = '';
    if (picUrl != null) {
      final fromData = FormData.fromMap({
        "user_uid": posterUid,
        "file": await MultipartFile.fromFile(picUrl)
      });
      var saveImgResponse = await dio.post('/images', data: fromData);
      saveImg = 'http://114.116.111.148:8081/qualia/img/';
      saveImg += saveImgResponse.data['data']['dir'];
    }
    return saveImg;
  }

  sendWish(
      int posterUid, int postToUid, String? picUrl, String wishContent) async {
    await tokenTest();
    Dio dio = AppRequestType().getDioWithToken(boxAccount.read('token'));
    var saveImg = await AppRequest().uploadImage(posterUid, picUrl);
    var response = await dio.post('/wishes', data: {
      'subject_useruid': posterUid,
      'object_useruid': postToUid,
      'content': wishContent,
      'wish_pics': saveImg,
      'start_date': DateTime.now().toString(),
      'valid_date': DateTime.now().toString()
    });
    return response.data;
  }

  signUp(String mobilePhone, String password) async {
    Dio dio = AppRequestType().getDio();
    var response = await dio.post('/users',
        data: {"mobile_phone": mobilePhone, "password": password});
    return response.data;
  }

  addFriend(int subUid, int objUid, String relation) async {
    await tokenTest();
    Dio dio = AppRequestType().getDioWithToken(boxAccount.read('token'));
    var response = await dio.post('/users/relations', data: {
      "subject_useruid": subUid,
      "object_useruid": objUid,
      'relation': relation
    });
    return response.data;
  }

  sendWanna(Wanna wanna) async {
    await tokenTest();
    Dio dio = AppRequestType().getDioWithToken(boxAccount.read('token'));
    var saveImg = "";
    if (wanna.wannaPics != "") {
      saveImg = await AppRequest().uploadImage(wanna.userUid, wanna.wannaPics);
    }
    var response = await dio.post('/wanna', data: {
      "subject_useruid": wanna.userUid,
      "content": wanna.content,
      "wanna_pics": saveImg
    });
    return response.data;
  }

  agreeOrRejectWish(Wish wish, String attitude) async {
    await tokenTest();
    Dio dio = AppRequestType().getDioWithToken(boxAccount.read('token'));
    var response = await dio.put('/wishes', data: {
      "operator_uid": boxAccount.read('user_uid'),
      "wish_uid": wish.wid,
      "object_useruid": boxAccount.read('user_uid'),
      "content": wish.content,
      "wish_pics": wish.wish_pics,
      "start_date": wish.start_date,
      "valid_date": wish.update_date,
      "status": attitude,
      "read": "true"
    });
    return response.data;
  }

  readWish(Wish wish) async {
    await tokenTest();
    Dio dio = AppRequestType().getDioWithToken(boxAccount.read('token'));
    var response = await dio.put('/wishes', data: {
      "operator_uid": boxAccount.read('user_uid'),
      "wish_uid": wish.wid,
      "object_useruid": boxAccount.read('user_uid'),
      "content": wish.content,
      "wish_pics": wish.wish_pics,
      "start_date": wish.start_date,
      "valid_date": wish.update_date,
      "status": wish.status,
      "read": "true"
    });
    return response.data;
  }

  getAllWanna(int userUid) async {
    await tokenTest();
    Dio dio = AppRequestType().getDioWithToken(boxAccount.read('token'));
    var response = await dio.post('/wanna_query', data: {
      "user_uid": boxAccount.read('user_uid'),
      "target_uid": userUid,
    });
    return response.data;
  }

  getOngoingWanna(int userUid) async {
    await tokenTest();
    Dio dio = AppRequestType().getDioWithToken(boxAccount.read('token'));
    var response = await dio.post('/wanna_query', data: {
      "user_uid": boxAccount.read('user_uid'),
      "target_uid": userUid,
      "status": 'ongoing'
    });
    return response.data;
  }

  getDoneWanna(int userUid) async {
    await tokenTest();
    Dio dio = AppRequestType().getDioWithToken(boxAccount.read('token'));
    var response = await dio.post('/wanna_query', data: {
      "user_uid": boxAccount.read('user_uid'),
      "target_uid": userUid,
      "status": 'done'
    });
    return response.data;
  }

  editWannaStatusDone(Wanna wanna) async {
    await tokenTest();
    Dio dio = AppRequestType().getDioWithToken(boxAccount.read('token'));
    var response = await dio.put('/wanna', data: {
      "operator_uid": boxAccount.read('user_uid'),
      "wanna_uid": wanna.wannaUid,
      "content": wanna.content,
      "wanna_pics": wanna.wannaPics,
      "status": "done"
    });
    return response.data;
  }

  logOut() async {
    await tokenTest();
    Dio dio = AppRequestType().getDioWithToken(boxAccount.read('token'));
    var response = await dio
        .post('/users/logout', data: {"user_uid": boxAccount.read('user_uid')});
    return response.data;
  }

  editUsername(String username) async {
    await tokenTest();
    var dio = AppRequestType().getDioWithToken(boxAccount.read('token'));
    var response = await dio.put('/users', data: {
      "user_uid": boxAccount.read('user_uid'),
      "edit_param": 99,
      "name": username,
      "gender": "M",
      "portrait": null,
      "desc": "",
      "mobile_phone": boxAccount.read('account'),
      "password": null
    });
    return response.data;
  }

  queryCloseByReminder(int userUid) async {
    await tokenTest();
    var dio = AppRequestType().getDioWithToken(boxAccount.read('token'));
    var response = await dio.get('/closeby_reminders?user_uid=$userUid');
    return response.data;
  }
  
  addBlock(int objUid) async {
    await tokenTest();
    int userUid=boxAccount.read('user_uid');
    var dio = AppRequestType().getDioWithToken(boxAccount.read('token'));
    var response = await dio.post('/users/blocklist',data: {
        "subject_uid":userUid ,
        "object_uid": objUid,
        "object_name": "",
        "object_portrait_url": "",
        "comment": ""
    });
    return response.data;
  }

  queryBlockList()async{
    await tokenTest();
    int userUid=boxAccount.read('user_uid');
    var dio = AppRequestType().getDioWithToken(boxAccount.read('token'));
    var response = await dio.get('/users/blocklist?user_uid=$userUid');
    List mapList=response.data['data'];
    List<Block> blockList=[];
    for (var item in mapList){
      blockList.add(Block(item['uid'],item['object_uid'],DateTime.parse(item['create_date'])));
    }
    return blockList;
  }

  Future<List<int>> queryBlockListUserIdList()async{
    await tokenTest();
    int userUid=boxAccount.read('user_uid');
    var dio = AppRequestType().getDioWithToken(boxAccount.read('token'));
    var response = await dio.get('/users/blocklist?user_uid=$userUid');
    List mapList=response.data['data'];
    List<int> blockUserIdList=[];
    for (var item in mapList){
      blockUserIdList.add(item['object_uid']);
    }
    return blockUserIdList;
  }

  deleteBlockUser(int blockId)async{
    await tokenTest();
    var dio = AppRequestType().getDioWithToken(boxAccount.read('token'));
    var response = await dio.delete('/users/blocklist?block_uid=$blockId');
    return response.data;
  }

  deleteWanna(Wanna wanna) async {
    var response;
    try{
      await tokenTest();
      var dio = AppRequestType().getDioWithToken(boxAccount.read('token'));
      response = await dio.delete(
          '/wanna?user_uid=${wanna.userUid}&wanna_uid=${wanna.wannaUid}');
      return response.data;
    }catch(e){
      response={
        'code':'000002'
      };
      return response;
    }
  }

  editWish(Wish wish,String content,String? wishPics)async{
    await tokenTest();
    Dio dio = AppRequestType().getDioWithToken(boxAccount.read('token'));
    var saveImg = await AppRequest().uploadImage(wish.subject_useruid, wishPics);
    var response = await dio.put('/wishes',data:
    {
      "operator_uid":wish.subject_useruid,
      "wish_uid":wish.wid,
      "object_useruid":wish.object_useruid,
      "content": content,
      "wish_pics":saveImg,
      "start_date":wish.start_date,
      "valid_date":wish.start_date,
      "status":wish.status,
      "read":wish.read
    }
    );
    return response.data;
  }

}
