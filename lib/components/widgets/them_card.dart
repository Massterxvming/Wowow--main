import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:wowowwish/components/widgets/portrait.dart';
import 'package:wowowwish/components/widgets/post_item_from_friend.dart';
import 'package:wowowwish/components/widgets/wanna_card_friend.dart';
import 'package:wowowwish/config/app_strings.dart';
import 'package:wowowwish/config/app_toast.dart';
import 'package:wowowwish/constants.dart';
import 'package:wowowwish/model/them.dart';
import 'package:wowowwish/pages/home/logic.dart';
import 'package:wowowwish/pages/home/view.dart';
import 'package:wowowwish/request/app_request.dart';
import 'package:wowowwish/request/requests.dart';
import 'package:wowowwish/styles/app_colors.dart';
import 'package:wowowwish/styles/app_style.dart';
import 'package:wowowwish/utils/app_utils.dart';
import '../../model/wanna.dart';
import '../../pages/home/user/logic.dart';
import '../../pages/home/wish/logic.dart';
import '../../routes/app_routes.dart';
import 'app_text_field.dart';

class ThemCard extends StatefulWidget {
  final MyThem myThem;
final int index;
  const ThemCard({
    super.key,
    required this.myThem, required this.index,
  });
  static const Map map = {
    'realMe': {'color': Color(0xFF000000), 'string': AppStrings.realMe},
    'lover': {'color': Color(0xFFFA7AE2), 'string': AppStrings.lover},
    'friend': {'color': Color(0xFF54D2F6), 'string': AppStrings.friend},
    'gene': {'color': Color(0xFF29DE45), 'string': AppStrings.gene}
  };

  @override
  State<ThemCard> createState() => _ThemCardState();
}

class _ThemCardState extends State<ThemCard> {
  String mobilePhone=boxAccount.read('account');

  void judgeUsername(BuildContext context, int index) {
    if ( username == '用户$mobilePhone') {
      _showCustomDialog(context, index);
    } else {
      Get.toNamed(Routes.WISHTO, arguments: [
        widget.myThem.relation,
        {
          'poster_uid': myUserUid,
          'post_to_uid': widget.myThem.userUid,
          'token': token
        }
      ]);
    }
  }

  String username=boxAccount.read('username');

  void _showCustomDialog(BuildContext context, int index) {
    showDialog<void>(
      context: context,
      // false = user must tap button, true = tap outside dialog
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Icon(
            Icons.sentiment_dissatisfied_sharp,
            size: 40,
          ),
          content: const Text(
            '糟糕！你还有没昵称\n起一个名字让大家都认识你吧',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.black,
              fontSize: 14,

              fontWeight: FontWeight.w400,
              height: 1.50,
            ),
          ),
          actions: <Widget>[
            AppTextField(
              hint: '请输入你的昵称',
              labelText: '昵称',
              onChanged: (val) {
                username = val;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  child: const SizedBox(
                    width: 57,
                    height: 20,
                    child: Text(
                      AppStrings.cancel,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.secondary,
                        fontSize: 14,

                        fontWeight: FontWeight.w400,
                        height: 1.50,
                      ),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(dialogContext).pop(); // Dismiss alert dialog
                  },
                ),
                TextButton(
                  child: const SizedBox(
                    width: 57,
                    height: 20,
                    child: Text(
                      AppStrings.confirm,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.secondary,
                        fontSize: 14,

                        fontWeight: FontWeight.w400,
                        height: 1.50,
                      ),
                    ),
                  ),
                  onPressed: () async {
                    if (username != boxAccount.read('username')) {
                      var response =
                      await AppRequest().editUsername(username);
                      if (response['code'] == '000001') {
                        appShowToast('修改成功');
                        await boxAccount.write('username', username);
                      }
                      Get.back();
                      var logicSuper = Get.find<UserLogic>();
                      logicSuper.updateUsername();
                    }
                    Get.toNamed(Routes.WISHTO, arguments: [
                      widget.myThem.relation,
                      {
                        'poster_uid': myUserUid,
                        'post_to_uid': widget.myThem.userUid,
                        'token': token
                      }
                    ]);
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  final int myUserUid = boxAccount.read('user_uid');

  final String token = boxAccount.read('token');

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.myThem.userUid != -1) {
          showFlexibleBottomSheet(
            bottomSheetColor: const Color(0x00FFFFFF),
            builder: _buildBottomSheetHeader,
            context: context,
            minHeight: 0,
            maxHeight: 0.93,
            initHeight: 0.93,
            anchors: [0, 0.93],
            isExpand: true,

            // isSafeArea: true
          );
        } else {
          Get.toNamed(Routes.ADDFRIEND,
              arguments: [myUserUid, widget.myThem.relation, token]);
          print('2:添加好友');
        }
      },
      child: widget.myThem.userUid != -1
          ? Container(
              height: 155,
              decoration: AppStyle.postItemBoxDecoration,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Portrait(
                            size: 22,
                            userUid: widget.myThem.userUid,
                            imgUrl: widget.myThem.portrait,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            flex: 7,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  ThemCard.map[widget.myThem.relation]['string'],
                                  style: const TextStyle(
                                    color: AppColors.textThemCardPri,
                                    fontSize: 14,

                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  widget.myThem.username!,
                                  style: const TextStyle(
                                    color: AppColors.textThemCardSec,
                                    fontSize: 12,

                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Icon(Icons.chevron_right),
                          const SizedBox(
                            width: 15,
                          )
                        ],
                      ),
                    ),
                    const Spacer(),
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: SizedBox(
                    //     height: 32,
                    //     width: 92,
                    //     child: ElevatedButton(
                    //       onPressed: () {
                    //         judgeUsername(context, widget.index);
                    //       },
                    //       style: ElevatedButton.styleFrom(
                    //         backgroundColor: Color(0xFFCFD5BD),
                    //         shape: RoundedRectangleBorder(
                    //           borderRadius: BorderRadius.circular(10),
                    //         ),
                    //       ),
                    //       child: const Text(
                    //         '许愿',
                    //         style: TextStyle(
                    //           color: Color(0xFF606356),
                    //           fontSize: 14,
                    //
                    //           fontWeight: FontWeight.w600,
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // )
                  ],
                ),
              ),
            )
          : Container(
              height: 155,
              decoration: AppStyle.postItemBoxDecoration,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Portrait(
                            size: 22,
                            userUid: widget.myThem.userUid,
                            imgUrl: widget.myThem.portrait,
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            flex: 7,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  ThemCard.map[widget.myThem.relation]['string'],
                                  style: const TextStyle(
                                    color: AppColors.textThemCardPri,
                                    fontSize: 14,

                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(
                                  height: 2,
                                ),
                                const Text(
                                  '未添加',
                                  style: TextStyle(
                                    color:AppColors.textThemCardSec,
                                    fontSize: 12,

                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Icon(Icons.chevron_right),
                          SizedBox(
                            width: 15,
                          )
                        ],
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 92,
                        height: 32,
                        child: ElevatedButton(
                          onPressed: () {
                            Get.toNamed(Routes.ADDFRIEND,
                                arguments: [myUserUid, widget.myThem.relation, token]);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryVariant,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            '添加',
                            style: TextStyle(
                              color: AppColors.textThemCardPri,
                              fontSize: 14,

                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildBottomSheetHeader(
    BuildContext context,
    ScrollController scrollController,
    double bottomSheetOffset,
  ) {
    return Container(
      height: Get.height*0.93,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
        color: AppColors.appBackground,
      ),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: SingleChildScrollView(
          controller: scrollController,
          child: SizedBox(
            height: Get.height*0.89,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 60,
                  height: 6,
                  decoration: const BoxDecoration(
                    color: Color(0xFF93978A),
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                GestureDetector(
                  onTap: (){
                    if(widget.myThem.portrait!=null){
                      showDialog<void>(
                        context: context,
                        barrierColor: AppColors.black,
                        builder: (BuildContext dialogContext) {
                          return ZoomableImage(
                            imageUrl: widget.myThem.portrait!,
                          );
                        },
                      );
                    }else{
                      appShowToast('对方未设置头像');
                    }
                  },
                  child: Portrait(
                    size: 75,
                    userUid: widget.myThem.userUid,
                    imgUrl: widget.myThem.portrait,
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Text(
                  widget.myThem.username!,
                  textAlign: TextAlign.center,
                  style:  TextStyle(
                    color: AppColors.font,
                    fontSize: 16,

                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Expanded(
                    flex: 4,
                    child: FriendWannaListViewComponent(myThem: widget.myThem)),
                Expanded(
                  flex: 6,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 216,
                      clipBehavior: Clip.antiAlias,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                              width: 0.50, color: AppColors.borderSideColor),
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const Text('我向Ta许过的愿望'),
                                Text('${widget.myThem.numMyWishTo}')
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const Text('Ta帮我实现的愿望'),
                                Text('${widget.myThem.numMyWishThemDone}')
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const Text('Ta向我许过的愿望'),
                                Text('${widget.myThem.numTheirWishToMe}')
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const Text('我帮Ta实现的愿望'),
                                Text('${widget.myThem.numTheirWishMeDone}')
                              ],
                            ),
                            SizedBox(
                              height: 12,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {
                        appShowDialog(context, '解除关系', '您确定要解除关系吗？', AppStrings.cancel,'解除' , () async {
                          await tokenTest();
                          Dio dio = AppRequestType().getDioWithToken(token);
                          var response = await dio.delete(
                              '/users/relations',
                              data: {"relation_uid": widget.myThem.relationId});
                          print(response.data);
                          if (response.data['code'] == '000001') {
                            var test = await AppRequest().getFriends(
                                boxAccount.read('user_uid'));
                            boxFriend.write('them', test);
                            appShowToast('删除成功');
                            Get.offAllNamed(Routes.HOME);
                          }
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.appBackground,
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                              width: 0.50, color: AppColors.borderSideColor),
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      child: const Text(
                        '解除关系',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFFE34848),
                          fontSize: 14,

                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FriendWannaListViewComponent extends StatefulWidget {
  const FriendWannaListViewComponent({Key? key, required this.myThem})
      : super(key: key);
  final MyThem myThem;

  @override
  State<FriendWannaListViewComponent> createState() =>
      _FriendWannaListViewComponentState();
}

class _FriendWannaListViewComponentState
    extends State<FriendWannaListViewComponent> {
  final PageController _pageController = PageController(initialPage: 50000);
  List displayList = [];
  @override
  void initState() {
    for(Map item in widget.myThem.wannaList){
      if(item['status']=='ongoing'){
        displayList.add(item);
      }
    }
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 136,
      child: displayList.isEmpty?
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 136,
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            color: AppColors.appBackground,
            shape: RoundedRectangleBorder(
              side: const BorderSide(
                  width: 0.50, color: AppColors.borderSideColor),
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 128,
                child: Text(
                  '没有更多啦......',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.hintColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      )
          :
      PageView.builder(
          controller: _pageController,
          itemCount: 100000,
          itemBuilder: (context, index) {
            // if (index == displayList.length) {
            //   return Padding(
            //     padding: const EdgeInsets.all(8.0),
            //     child: Container(
            //       height: 136,
            //       clipBehavior: Clip.antiAlias,
            //       decoration: ShapeDecoration(
            //         color: AppColors.appBackground,
            //         shape: RoundedRectangleBorder(
            //           side: const BorderSide(
            //               width: 0.50, color: AppColors.borderSideColor),
            //           borderRadius: BorderRadius.circular(6),
            //         ),
            //       ),
            //       child: const Row(
            //         mainAxisSize: MainAxisSize.min,
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         crossAxisAlignment: CrossAxisAlignment.center,
            //         children: [
            //           SizedBox(
            //             width: 128,
            //             child: Text(
            //               '没有更多啦......',
            //               textAlign: TextAlign.center,
            //               style: TextStyle(
            //                 color: AppColors.hintColor,
            //                 fontSize: 14,
            //                 fontWeight: FontWeight.w500,
            //               ),
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //   );
            // } else {
            return Stack(
                children: [
                  WannaCard(
                      wanna: Wanna.fromJson(displayList[index % displayList.length])),
                  Positioned(
                    top: 0,
                    bottom: 0,
                    right: 0,
                    child: IconButton(
                        onPressed: () {
                            _pageController.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut);

                        },
                        icon: SvgPicture.asset('assets/images/right_guide.svg',height: 25,width: 25,clipBehavior: Clip.antiAlias,)),
                  ),
                  Positioned(
                      top: 0,
                      bottom: 0,
                      left: 0,
                      child: IconButton(
                        onPressed: () {
                            _pageController.previousPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut);
                        },
                        icon: SvgPicture.asset('assets/images/left_guide.svg',height: 25,width: 25,clipBehavior: Clip.antiAlias,),)
                  )
                ],
              );
            }
            // }
          ),
    );
  }
}
