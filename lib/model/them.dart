import 'package:dio/dio.dart';
import 'package:wowowwish/constants.dart';

import '../request/app_request.dart';

class MyThem {
  int userUid;
  int? relationId;
  String? username;
  String? portrait;
  String? qualiaId;
  String? mobilePhone;
  List wannaList = [];
  int? numMyWishTo;
  int? numMyWishThemDone;
  int? numTheirWishMeDone;
  int? numTheirWishToMe;
  final String relation;
  List? wishListToThem;
  List? wishListFromThem;

  MyThem({
    required this.relation,
    this.userUid = -1,
    this.username,
    this.portrait,
    this.qualiaId,
    this.mobilePhone,
    this.relationId,
    this.numMyWishTo,
    this.numMyWishThemDone,
    this.numTheirWishMeDone,
    this.numTheirWishToMe,
  });

  void getWishTo(token, myUid) async {
    await tokenTest();
    Dio dio = AppRequestType().getDioWithToken(boxAccount.read('token'));
    var response = await dio.post('/wishes_query',
        data: {"user_uid": myUid, "subject_uid": myUid, "object_uid": userUid});
    wishListToThem = response.data['data'];
  }

  Future<void> getWanna(token, myUid) async {
    await tokenTest();
    Dio dio = AppRequestType().getDioWithToken(boxAccount.read('token'));
    var response = await dio.post('/wanna_query', data: {
      "user_uid": myUid,
      "target_uid": userUid,
    });
    wannaList = response.data['data'];
  }

  factory MyThem.fromJson(Map<dynamic, dynamic> json) => MyThem(
        userUid: json['user_uid'],
        mobilePhone: json['mobile_phone'],
        username: json['username'],
        portrait: json['portrait'],
        qualiaId: json['qualia_id'],
        relationId: json['relation_id'],
        relation: json['relation'],
        numMyWishTo: json['to_target_all'],
        numMyWishThemDone: json['to_target_acpt'],
        numTheirWishMeDone: json['from_target_acpt'],
        numTheirWishToMe: json['from_target_all'],
      );

  Map toMap() {
    return {
      "relation": relation,
      "relation_id": relationId,
      'user_uid': userUid,
      'username': username,
      'portrait': portrait,
      'qualia_id': qualiaId,
      'mobile_phone': mobilePhone,
      'wanna_list': wannaList,
      'wish_list_to_them': wishListToThem,
      'wish_list_from_them': wishListFromThem,
      'to_target_all':numMyWishTo,
      'to_target_acpt':numMyWishThemDone,
      'from_target_all':numTheirWishToMe,
      'from_target_acpt':numTheirWishMeDone
    };
  }

  Future<void> getNumbers(token, myUid) async {
    await tokenTest();
    Dio dio = AppRequestType().getDioWithToken(boxAccount.read('token'));
    var response =
        await dio.get('/wishes_num?user_uid=$myUid&target_uid=$userUid');
    var numMap = response.data['data'];
    numMyWishTo = numMap['to_target_all'];
    numMyWishThemDone = numMap['to_target_acpt'];
    numTheirWishToMe = numMap['from_target_all'];
    numTheirWishMeDone = numMap['from_target_acpt'];
  }
}
//
// class Lover extends MyThem {
//   List? wishListToThem;
//   List? wishListFromThem;
//   Lover(
//       {int userUid = -1,
//       String? username,
//       String? portrait,
//       String? qualiaId,
//       String? mobilePhone,
//       int? relationId})
//       : super('lover', userUid, username, portrait, qualiaId, mobilePhone,
//             relationId);
//
//   @override
//   void getWishTo(token, myUid) async {
//     Dio dio = AppRequest().getDioWithToken(token);
//     var response = await dio.post('/wishes_query',
//         data: {"user_uid": myUid, "subject_uid": myUid, "object_uid": userUid});
//     wishListToThem = response.data['data'];
//   }
//
//   void getWishFrom(token, myUid) async {
//     Dio dio = AppRequest().getDioWithToken(token);
//     var response = await dio.post('/wishes_query',
//         data: {"user_uid": myUid, "subject_uid": userUid, "object_uid": myUid});
//     wishListFromThem = response.data['data'];
//   }
//
//   @override
//   void getWanna(token, myUid) async {
//     Dio dio = AppRequest().getDioWithToken(token);
//     var response = await dio.post('/wanna_query', data: {
//       "user_uid": myUid,
//       "target_uid": userUid,
//     });
//     wannaList = response.data['data'];
//   }
//
//   factory Lover.fromJson(Map<dynamic, dynamic> json) => Lover(
//       userUid: json['user_uid'],
//       mobilePhone: json['mobile_phone'],
//       username: json['username'],
//       portrait: json['portrait'],
//       qualiaId: json['qualia_id'],
//       relationId: json['relation_id']);
//   Map toMap() {
//     return {
//       "relation": relation,
//       "relation_id": relationId,
//       'user_uid': userUid,
//       'username': username,
//       'portrait': portrait,
//       'qualia_id': qualiaId,
//       'mobile_phone': mobilePhone,
//       'wanna_list': wannaList,
//       'wish_list_to_them': wishListToThem,
//       'wish_list_from_them': wishListFromThem,
//     };
//   }
//
//   @override
//   void getNumbers(token, myUid) async {
//     Dio dio = AppRequest().getDioWithToken(token);
//     var response =
//         await dio.get('/wishes_num?user_uid=$myUid&target_uid=$userUid');
//     var numMap = response.data['data'];
//     numMyWishTo = numMap['to_target_all'];
//     numMyWishThemDone = numMap['to_target_acpt'];
//     numTheirWishToMe = numMap['from_target_all'];
//     numTheirWishMeDone = numMap['from_target_acpt'];
//   }
// }
//
// class Friend extends MyThem {
//   List? wishListToThem;
//   List? wishListFromThem;
//   Friend(
//       {int userUid = -1,
//       String? username,
//       String? portrait,
//       String? qualiaId,
//       String? mobilePhone,
//       int? relationId})
//       : super('friend', userUid, username, portrait, qualiaId, mobilePhone,
//             relationId);
//   @override
//   void getWishTo(token, myUid) async {
//     Dio dio = AppRequest().getDioWithToken(token);
//     var response = await dio.post('/wishes_query',
//         data: {"user_uid": myUid, "subject_uid": myUid, "object_uid": userUid});
//     wishListToThem = response.data['data'];
//   }
//
//   factory Friend.fromJson(Map<dynamic, dynamic> json) => Friend(
//       userUid: json['user_uid'],
//       mobilePhone: json['mobile_phone'],
//       username: json['username'],
//       portrait: json['portrait'],
//       qualiaId: json['qualia_id'],
//       relationId: json['relation_id']);
//   void getWishFrom(token, myUid) async {
//     Dio dio = AppRequest().getDioWithToken(token);
//     var response = await dio.post('/wishes_query',
//         data: {"user_uid": myUid, "subject_uid": userUid, "object_uid": myUid});
//     wishListFromThem = response.data['data'];
//   }
//
//   Map toMap() {
//     return {
//       "relation": relation,
//       "relation_id": relationId,
//       'user_uid': userUid,
//       'username': username,
//       'portrait': portrait,
//       'qualia_id': qualiaId,
//       'mobile_phone': mobilePhone,
//       'wanna_list': wannaList,
//       'wish_list_to_them': wishListToThem,
//       'wish_list_from_them': wishListFromThem,
//     };
//   }
//
//   @override
//   void getWanna(token, myUid) async {
//     Dio dio = AppRequest().getDioWithToken(token);
//     var response = await dio.post('/wanna_query', data: {
//       "user_uid": myUid,
//       "target_uid": userUid,
//     });
//     wannaList = response.data['data'];
//   }
//
//   @override
//   void getNumbers(token, myUid) async {
//     Dio dio = AppRequest().getDioWithToken(token);
//     var response =
//         await dio.get('/wishes_num?user_uid=$myUid&target_uid=$userUid');
//     var numMap = response.data['data'];
//     numMyWishTo = numMap['to_target_all'];
//     numMyWishThemDone = numMap['to_target_acpt'];
//     numTheirWishToMe = numMap['from_target_all'];
//     numTheirWishMeDone = numMap['from_target_acpt'];
//   }
// }
//
// class Gene extends MyThem {
//   List? wishListToThem;
//   List? wishListFromThem;
//   Gene(
//       {int userUid = -1,
//       String? username,
//       String? portrait,
//       String? qualiaId,
//       String? mobilePhone,
//       int? relationId})
//       : super('gene', userUid, username, portrait, qualiaId, mobilePhone,
//             relationId);
//   @override
//   factory Gene.fromJson(Map<dynamic, dynamic> json) => Gene(
//       userUid: json['user_uid'],
//       mobilePhone: json['mobile_phone'],
//       username: json['username'],
//       portrait: json['portrait'],
//       qualiaId: json['qualia_id'],
//       relationId: json['relation_id']);
//   @override
//   void getWishTo(token, myUid) async {
//     Dio dio = AppRequest().getDioWithToken(token);
//     var response = await dio.post('/wishes_query',
//         data: {"user_uid": myUid, "subject_uid": myUid, "object_uid": userUid});
//     wishListToThem = response.data['data'];
//   }
//
//   void getWishFrom(token, myUid) async {
//     Dio dio = AppRequest().getDioWithToken(token);
//     var response = await dio.post('/wishes_query',
//         data: {"user_uid": myUid, "subject_uid": userUid, "object_uid": myUid});
//     wishListFromThem = response.data['data'];
//   }
//
//   Map toMap() {
//     return {
//       "relation": relation,
//       "relation_id": relationId,
//       'user_uid': userUid,
//       'username': username,
//       'portrait': portrait,
//       'qualia_id': qualiaId,
//       'mobile_phone': mobilePhone,
//       'wanna_list': wannaList,
//       'wish_list_to_them': wishListToThem,
//       'wish_list_from_them': wishListFromThem,
//     };
//   }
//
//   @override
//   void getWanna(token, myUid) async {
//     Dio dio = AppRequest().getDioWithToken(token);
//     var response = await dio.post('/wanna_query', data: {
//       "user_uid": myUid,
//       "target_uid": userUid,
//     });
//     wannaList = response.data['data'];
//   }
//
//   @override
//   void getNumbers(token, myUid) async {
//     Dio dio = AppRequest().getDioWithToken(token);
//     var response =
//         await dio.get('/wishes_num?user_uid=$myUid&target_uid=$userUid');
//     Map numMap = response.data['data'];
//     numMyWishTo = numMap['to_target_all'];
//     numMyWishThemDone = numMap['to_target_acpt'];
//     numTheirWishToMe = numMap['from_target_all'];
//     numTheirWishMeDone = numMap['from_target_acpt'];
//   }
// }
