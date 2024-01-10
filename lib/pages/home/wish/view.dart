import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wowowwish/components/my_wish_list/view.dart';
import 'package:wowowwish/components/widgets/REmptyView.dart';
import 'package:wowowwish/components/widgets/app_text_field.dart';
import 'package:wowowwish/components/widgets/app_tool_bar.dart';
import 'package:wowowwish/components/widgets/post_item_from_friend.dart';
import 'package:wowowwish/components/widgets/reminder_closeby_card.dart';
import 'package:wowowwish/components/widgets/them_card_home.dart';
import 'package:wowowwish/config/app_strings.dart';
import 'package:wowowwish/config/app_toast.dart';
import 'package:wowowwish/model/reminder_simple.dart';
import 'package:wowowwish/pages/home/add_friend/logic.dart';
import 'package:wowowwish/routes/app_routes.dart';
import 'package:wowowwish/styles/app_colors.dart';
import '../../../components/widgets/null_view.dart';
import '../../../constants.dart';
import '../../../request/requests.dart';
import '../../../styles/app_style.dart';
import '../user/logic.dart';
import 'logic.dart';

class WishPage extends StatefulWidget {
  const WishPage({Key? key}) : super(key: key);

  @override
  State<WishPage> createState() => _WishPageState();
}

class _WishPageState extends State<WishPage> {
  final logic = Get.put(WishLogic());
  Them currentIndex = Them.gene;
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      appBar: ToolBar(
        title: '许愿',
        leading: IconButton(
          onPressed: () {
            FocusScope.of(context).requestFocus(FocusNode());
            Get.toNamed(Routes.WISHTO, arguments: [
              'tree',
              {
                'poster_uid': logic.account.userUid,
                'post_to_uid': 1,
                'token': logic.token
              }
            ]);
          },
          icon: const Icon(
            Icons.park_outlined,
            color: AppColors.black,
            size: 22,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                FocusScope.of(context).requestFocus(FocusNode());
                Get.toNamed(Routes.WANT);
              },
              icon: const Icon(Icons.card_giftcard)),
        ],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: FutureBuilder(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return const Center(
                  child: REmptyView(dataText: '网络错误\n请检查网络连接'),
                );
              } else {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      flex: 7,
                      child: logic.friendList[currentIndex.index]['user_uid'] == -1
                        ? const REmptyView(dataText: '暂无好友信息\n点击下方卡片添加好友吧')
                        :
                    MyWishListComponent(
                      myWishList:
                      logic.myWishCardList[currentIndex.index],
                      objectUid:
                      logic.friendList[currentIndex.index]
                      ['user_uid'],
                    ),),

                    Expanded(
                      flex: 2,
                      child: HomeUserCardSelect(
                        currentIndex: currentIndex,
                        onTap: (value) {
                          setState(() {
                            currentIndex = value;
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 18),
                      child: SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.appBackground,
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                    width: 0.48,
                                    color: AppColors.borderSideColor),
                                borderRadius: BorderRadius.circular(9),
                              ),
                            ),
                            onPressed: () {
                              Get.toNamed(Routes.WISHTO, arguments: [
                                'realMe',
                                {
                                  'poster_uid': logic.account.userUid,
                                  'post_to_uid': logic.account.userUid,
                                  'token': logic.token
                                }
                              ]);
                            },
                            child: const Text(
                              '向真实的我许愿',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppColors.textOnUserAndWish,
                                fontSize: 14,

                                fontWeight: FontWeight.w600,
                              ),
                            )),
                      ),
                    ),

                  ],
                );
              }
            } else {
              return logic.friendList.isEmpty
                  ? const Center(
                      child: SizedBox(
                          height: 50,
                          width: 50,
                          child: CircularProgressIndicator()))
                  : Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        flex: 7,
                        child:  logic.friendList[currentIndex.index]
                      ['user_uid'] ==
                          -1
                          ? const REmptyView(dataText: '暂无好友信息\n点击下方卡片添加好友吧')
                          : MyWishListComponent(
                        myWishList: logic
                            .myWishCardList[currentIndex.index],
                        objectUid:
                        logic.friendList[currentIndex.index]
                        ['user_uid'],
                      ),),

                      Expanded(
                        flex: 2,
                        child: HomeUserCardSelect(
                          currentIndex: currentIndex,
                          onTap: (value) {
                            setState(() {
                              currentIndex = value;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 18),
                        child: SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    AppColors.appBackground,
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                      width: 0.48,
                                      color: AppColors.borderSideColor),
                                  borderRadius:
                                      BorderRadius.circular(9),
                                ),
                              ),
                              onPressed: () {
                                Get.toNamed(Routes.WISHTO, arguments: [
                                  'realMe',
                                  {
                                    'poster_uid': logic.account.userUid,
                                    'post_to_uid':
                                        logic.account.userUid,
                                    'token': logic.token
                                  }
                                ]);
                              },
                              child: const Text(
                                '向真实的我许愿',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AppColors.textOnUserAndWish,
                                  fontSize: 14,

                                  fontWeight: FontWeight.w600,
                                ),
                              )),
                        ),
                      ),
                    ],
                  );
            }
          },
        ),
      ),
    );
  }

  @override
  void initState() {
    if(box.hasData('initWishCard')){
      String initValue = box.read('initWishCard');
      currentIndex = initValue=='gene'?Them.gene:initValue=='lover'?Them.lover:Them.friend;
      box.remove('initWishCard');
    }else{
      var count = 0;
      currentIndex = Them.gene;
      logic.friendList = boxFriend.read('wish_to');
      int num = 0;
      for (var item in logic.friendList) {
        if (item['wish_list_to_them'] == null) {
          logic.myWishCardList[count] = [];
        } else {
          logic.myWishCardList[count] = item['wish_list_to_them'];
          if (logic.myWishCardList[count].length >= num) {
            currentIndex = Them.values[count];
            num = logic.myWishCardList[count].length;
          }
        }
        count++;
      }
    }
    // TODO: implement initState
    super.initState();
  }

  Future getData() async {
    int userUid = boxAccount.read('user_uid');
    List myFriendsInfo = await AppRequest().getFriendsWishToList(userUid);
    await boxFriend.write(
      'wish_to',
      myFriendsInfo,
    );
    logic.friendList = boxFriend.read('wish_to');
    var count = 0;
    for (var item in logic.friendList) {
      if (item['wish_list_to_them'] == null) {
        logic.myWishCardList[count] = [];
      } else {
        logic.myWishCardList[count] = item['wish_list_to_them'];
      }
      count++;
    }
    var temp = (await AppRequest().queryCloseByReminder(userUid))['data'];
    logic.reminderList = [];
    for (Map item in temp) {
      SimpleReminder simpleReminder = SimpleReminder.fromJson(item);
      if (simpleReminder.gap < 30 && simpleReminder.gap >= 0) {
        if (simpleReminder.userUid == userUid && simpleReminder.gap > 0) {}
        logic.reminderList.add(simpleReminder);
      }
    }
    logic.reminderList.sort(
      (a, b) => a.gap.compareTo(b.gap),
    );
  }
}

class HomeUserCardSelect extends StatefulWidget {
  const HomeUserCardSelect(
      {super.key, required this.currentIndex, required this.onTap});
  final Them currentIndex;
  final ValueChanged<Them> onTap;

  @override
  State<HomeUserCardSelect> createState() => _HomeUserCardSelectState();
}

class _HomeUserCardSelectState extends State<HomeUserCardSelect> {
  final logic = Get.put(WishLogic());

  final List relationWithMe = ['lover', 'realMe', 'gene', 'friend'];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 0,
        left: 16,
        right: 16,
        bottom: 0.5,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: HomeUserCard(
              onTap: () {
                if (widget.currentIndex == Them.gene) {
                  if (logic.friendList[0]['user_uid'] == -1) {
                    Get.toNamed(Routes.ADDFRIEND, arguments: [
                      logic.account.userUid,
                      relationWithMe[2],
                      logic.token
                    ]);
                  } else {
                    judgeUsername(context, 0);
                  }
                } else {
                  widget.onTap(Them.gene);
                }
              },
              current: widget.currentIndex,
              name: Them.gene,
              userUid: logic.friendList[0]['user_uid'],
              portrait: logic.friendList[0]['portrait'],
            ),
          ),
          Expanded(
            child: HomeUserCard(
              onTap: () {
                if (widget.currentIndex == Them.lover) {
                  if (logic.friendList[1]['user_uid'] == -1) {
                    Get.toNamed(Routes.ADDFRIEND, arguments: [
                      logic.account.userUid,
                      relationWithMe[0],
                      logic.token
                    ]);
                  } else {
                    judgeUsername(context, 1);
                  }
                } else {
                  widget.onTap(Them.lover);
                }
              },
              current: widget.currentIndex,
              name: Them.lover,
              userUid: logic.friendList[1]['user_uid'],
              portrait: logic.friendList[1]['portrait'],
            ),
          ),
          Expanded(
            child: HomeUserCard(
              onTap: () {
                if (widget.currentIndex == Them.friend) {
                  if (logic.friendList[2]['user_uid'] == -1) {
                    Get.toNamed(Routes.ADDFRIEND, arguments: [
                      logic.account.userUid,
                      relationWithMe[3],
                      logic.token
                    ]);
                  } else {
                    judgeUsername(context, 2);
                  }
                } else {
                  widget.onTap(Them.friend);
                }
              },
              current: widget.currentIndex,
              name: Them.friend,
              userUid: logic.friendList[2]['user_uid'],
              portrait: logic.friendList[2]['portrait'],
            ),
          ),
        ],
      ),
    );
  }

  judgeUsername(BuildContext context, int index) {
    FocusScope.of(context).requestFocus(FocusNode());
    if (logic.account.name == '用户${logic.account.mobilePhone}') {
      _showCustomDialog(context, index);
    } else {
      showDialog<void>(
        context: context,
        barrierColor: AppColors.barrierColor,
        // false = user must tap button, true = tap outside dialog
        builder: (BuildContext dialogContext) {
          return FocusScope(
            node: FocusScopeNode(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ReminderCloseByCard(
                 simpleReminderList: logic.reminderList,
                ),
              ],
            ),
          );
        },
      );
      showModalBottomSheet(
          context: context,
          backgroundColor: AppColors.appBackground,
          barrierColor: Color(0x00FFFFFF),
          builder: (context) {
            return Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: SingleChildScrollView(
                child: SendWishToBottomSheet(
                  postToUid: logic.friendList[index]['user_uid'],
                  posterUid: logic.account.userUid,
                  them: Them.values[index],
                ),
              ),
            );
          });
    }
  }

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
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              height: 1.50,
            ),
          ),
          actions: <Widget>[
            TextField(
              maxLength: 40,
              onChanged: (val) {
                logic.account.name = val;
              },
              decoration: InputDecoration(
                counterText: '',
                hintText: '请输入您的愿望',
                labelText: '您的愿望',
                labelStyle: const TextStyle(
                  color: AppColors.black,
                ),
                border:  const OutlineInputBorder(),
                enabledBorder:  const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.appBackground,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:  const BorderSide(
                    color: AppColors.appBackground,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                floatingLabelStyle:  const TextStyle(color: AppColors.floatingLabelTextColor),
                filled: true,
                fillColor: AppColors.appBackground,
              ),
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
                    if (logic.account.name != boxAccount.read('username')) {
                      var response =
                          await AppRequest().editUsername(logic.account.name);
                      if (response['code'] == '000001') {
                        appShowToast('修改成功');
                        await boxAccount.write('username', logic.account.name);
                      }
                      Get.back();
                      var logicSuper = Get.find<UserLogic>();
                      logicSuper.updateUsername();
                    }
                    await Get.toNamed(Routes.WISHTO, arguments: [
                      WishLogic.list[index],
                      {
                        'poster_uid': logic.account.userUid,
                        'post_to_uid': logic.friendList[index]['user_uid'],
                        'token': logic.token
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
}

class SendWishToBottomSheet extends StatefulWidget {
  const SendWishToBottomSheet(
      {super.key, required this.postToUid, required this.posterUid, required this.them});
  final int postToUid;
  final int posterUid;
  final Them them;
  @override
  State<SendWishToBottomSheet> createState() => _SendWishToBottomSheetState();
}

class _SendWishToBottomSheetState extends State<SendWishToBottomSheet> {
  String content = '';
  File? imageSelect;
  late String? picUrl;
  RxBool isLoading = false.obs;
  void showLoading() {
    isLoading.value = true;
    Get.dialog(
        Center(
          child: Container(
            height: 100,
            width: 100,
            decoration: AppStyle.shapeDecoration,
            child: const Padding(
              padding: EdgeInsets.all(26.0),
              child: CircularProgressIndicator(
                color: AppColors.bottomNvAndLoading,
              ),
            ),
          ),
        ),
        barrierDismissible: false);
  }

  void hideLoading() {
    isLoading.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          height: 120,
          width: double.infinity,
          decoration: const ShapeDecoration(
            color: AppColors.appBackground,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            shadows: [
              BoxShadow(
                color: AppColors.shadowColor,
                blurRadius: 10,
                offset: Offset(0, -2),
                spreadRadius: 0,
              )
            ],
          ),
          child: Padding(
            padding: EdgeInsets.only(
                top: 0,
                bottom: MediaQuery.of(context).padding.bottom,
                left: 12,
                right: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          onChanged: (val) {
                            content = val;
                          },
                          autofocus: true,
                          maxLines: 1,
                          maxLength: 40,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,

                            fontWeight: FontWeight.w400,
                          ),
                          cursorWidth: 1,
                          decoration: const InputDecoration(
                            hintStyle: TextStyle(color: AppColors.hintColor),
                            counterText: '',
                            counterStyle: TextStyle(fontSize: 8),
                            border: InputBorder.none,
                            hintText: '请输入内容(40字内)',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      imageSelect == null
                          ? Container()
                          : Center(
                              child: GestureDetector(
                                onTap: (){
                                  showDialog<void>(
                                    context: context,
                                    barrierColor: AppColors.black,
                                    builder: (BuildContext dialogContext) {
                                      return Container(child: Stack(
                                        children: [
                                          ZoomableImageFromFile(image: imageSelect!,),
                                          Positioned(
                                            right:0,top:0,child: IconButton(onPressed: (){
                                              Get.back();
                                              setState(() {
                                                imageSelect=null;
                                              });
                                          }, icon: Icon(Icons.delete,color: Colors.white,)),)
                                        ],
                                      ));
                                    },
                                  );
                                },
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: ShapeDecoration(
                                    image: DecorationImage(
                                      image: FileImage(imageSelect!),
                                      fit: BoxFit.fill,
                                    ),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(9)),
                                  ),
                                ),
                              ),
                            ),
                      const Spacer(),
                      IconButton(
                          onPressed: () async {
                            FocusScope.of(context).requestFocus(FocusNode());
                            PermissionStatus status =
                                await Permission.photos.status;
                            if (!status.isGranted) {
                              status = await Permission.photos.request();
                            }
                            final ImagePicker imagePicker = ImagePicker();
                            XFile? image1 = await imagePicker.pickImage(
                                source: ImageSource.gallery,
                                maxHeight: 1080,
                                maxWidth: 1080);
                            if (image1 != null) {
                              setState(() {
                                imageSelect = File(image1.path);
                              });
                            } else {
                              appShowToast('已取消');
                            }
                          },
                          icon: const Icon(
                            Icons.add_photo_alternate_outlined,
                          )),
                      IconButton(
                          onPressed: () async {
                            PermissionStatus status =
                                await Permission.camera.status;
                            if (!status.isGranted) {
                              status = await Permission.camera.request();
                            }
                            final ImagePicker imagePicker = ImagePicker();
                            XFile? image1 = await imagePicker.pickImage(
                                source: ImageSource.camera,
                                maxHeight: 1080,
                                maxWidth: 1080);
                            if (image1 != null) {
                              setState(() {
                                imageSelect = File(image1.path);
                              });
                            } else {
                              appShowToast('已取消');
                            }
                          },
                          icon: const Icon(
                            Icons.camera_alt_outlined,
                            size: 25,
                          )),
                      IconButton(
                          onPressed: () {
                            FocusScope.of(context).requestFocus(FocusNode());
                          },
                          icon: const Icon(
                            Icons.keyboard_hide_outlined,
                            size: 25,
                          )),
                      const SizedBox(
                        width: 5,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          showLoading();
                          picUrl =
                              imageSelect == null ? null : imageSelect!.path;
                          if (content != '') {
                            var response = await AppRequest().sendWish(
                                widget.posterUid,
                                widget.postToUid,
                                picUrl,
                                content);
                            if (response['code'] == '000001') {
                              var test = await AppRequest()
                                  .getFriends(widget.posterUid);
                              boxFriend.write('them', test);
                              appShowToast('许愿成功');
                              box.write('initWishCard', widget.them.name);
                              Get.offAllNamed(Routes.HOME);
                            } else {
                              appShowToast('许愿失败，请检查网络或稍后重试。');
                              Get.back();
                            }
                          } else {
                            appShowToast('愿望内容不能为空');
                            Get.back();
                          }
                          hideLoading();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.appBackground,
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                                width: 0.48, color: AppColors.borderSideColor),
                            borderRadius: BorderRadius.circular(9),
                          ),
                        ),
                        child: const Text(
                          '发送',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    Get.back();
    // TODO: implement dispose
    super.dispose();
  }
}
