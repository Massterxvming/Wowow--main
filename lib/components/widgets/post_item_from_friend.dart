import 'dart:io';
import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_view/photo_view.dart';
import 'package:wowowwish/components/widgets/portrait.dart';
import 'package:wowowwish/components/widgets/them_card.dart';
import 'package:wowowwish/config/app_strings.dart';
import 'package:wowowwish/config/app_toast.dart';
import 'package:wowowwish/constants.dart';
import 'package:wowowwish/model/them.dart';
import 'package:wowowwish/model/wish.dart';
import 'package:wowowwish/pages/home/view.dart';
import 'package:wowowwish/request/app_request.dart';
import 'package:wowowwish/request/requests.dart';
import 'package:wowowwish/styles/app_style.dart';
import 'package:wowowwish/utils/app_utils.dart';
import '../../pages/home/logic.dart';
import '../../styles/app_colors.dart';

class PostItem extends StatefulWidget {
  const PostItem({
    super.key,
    this.relation = 'realMe',
    required this.friendWish,
  });
  final String relation;
  final Wish friendWish;

  @override
  State<PostItem> createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {
  late MyThem myThem;
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
              )),
        ),
        barrierDismissible: false);
  }

  void hideLoading() {
    isLoading.value = false;
  }

  @override
  Widget build(BuildContext context) {
    String gap = getGap();
    if (widget.friendWish.status == 'invisible') {
      return Container();
    }
    return FutureBuilder(
      future: getUserData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                children: [
                  Container(
                    height: widget.friendWish.wish_pics == "" ? 200 : 356,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: AppColors.appBackground,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.shadowColor,
                          blurRadius: 10,
                          offset: Offset(0, 2),
                          spreadRadius: 0,
                        )
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                    ),
                    child: Center(child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(onPressed: (){
                          setState(() {
                          });
                        }, icon: Icon(Icons.refresh)),
                        const Text('加载失败'),
                      ],
                    )),
                  ),
                  widget.friendWish.read=='false'?const Positioned(
                    top: 0,right: 0,
                      child: CircleAvatar(radius: 5,backgroundColor: Colors.red,)):Container()
                ],
              ),
            );
          } else {
            return widget.friendWish.wish_pics == ""
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      children: [
                        Container(
                          height: 200,
                          padding: const EdgeInsets.only(
                              top: 10, left: 4, right: 4, bottom: 10),
                          decoration: AppStyle.boxDecoration,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 5,
                              ),
                              Expanded(
                                flex: 5,
                                child: Row(
                                  children: [
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        if (myThem.portrait == null ||
                                            myThem.portrait == '') {
                                          appShowToast('对方未设置头像');
                                        } else {
                                          showDialog<void>(
                                            context: context,
                                            barrierColor: AppColors.black,
                                            builder: (BuildContext dialogContext) {
                                              return ZoomableImage(
                                                imageUrl: myThem.portrait!,
                                              );
                                            },
                                          );
                                        }
                                      },
                                      child: Portrait(
                                          size: 18,
                                          userUid:
                                              widget.friendWish.subject_useruid,
                                          imgUrl: myThem.portrait == ''
                                              ? null
                                              : myThem.portrait),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      myThem.username!,
                                      style: const TextStyle(
                                        color: AppColors.font,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Container(
                                      width: 40,
                                      height: 15,
                                      decoration: ShapeDecoration(
                                        color: AppColors.black,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(3)),
                                      ),
                                      child: Center(
                                        child: Text(
                                          gap,
                                          style: const TextStyle(
                                            color: AppColors.white,
                                            fontSize: 7,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Spacer(),
                                    PopupMenuButton(onSelected: (value) async {
                                      switch (value) {
                                        case 0:
                                          showFlexibleBottomSheet(
                                            bottomSheetColor:Color(0x0),
                                            builder: _buildBottomSheetUserInfo,
                                            context: context,
                                            minHeight: 0,
                                            maxHeight: 0.93,
                                            initHeight: 0.93,
                                            anchors: [0, 0.93],
                                            isExpand: true,
                                          );
                                          break;
                                        case 1:
                                          if (widget.friendWish.status ==
                                              'pending') {
                                            var response = await AppRequest()
                                                .agreeOrRejectWish(
                                                    widget.friendWish, 'invisible');
                                            if (response['code'] == '000001') {
                                              setState(() {
                                                widget.friendWish.status =
                                                    'invisible';
                                              });
                                              updateBox();
                                            } else {
                                              appShowToast('网络连接错误，请稍后重试');
                                            }
                                          } else {
                                            appShowToast('您已表态的愿望不可被删除哦');
                                          }
                                          break;
                                        default:
                                      }
                                    }, itemBuilder: (context) {
                                      return [
                                        const PopupMenuItem(
                                            value: 0,
                                            child: Row(
                                              children: [
                                                Text(
                                                  '许愿人详情',
                                                  style: TextStyle(
                                                    color: AppColors.black,
                                                    fontSize: 14,

                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                Spacer(),
                                                Icon(
                                                  Icons.handshake_outlined,
                                                  color: AppColors.black,
                                                )
                                              ],
                                            )),
                                        const PopupMenuItem(
                                          value: 1,
                                          child: Row(children: [
                                            Text('删除',
                                                style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 14,

                                                  fontWeight: FontWeight.w500,
                                                )),
                                            Spacer(),
                                            Icon(
                                              Icons.delete_forever_outlined,
                                              color: Colors.red,
                                            )
                                          ]),
                                        ),
                                      ];
                                    })
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 10,
                                child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.only(
                                      left: 8, right: 8, bottom: 10),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Container(
                                          width: double.infinity,
                                          padding: const EdgeInsets.only(
                                              left: 15, right: 15, top: 5),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  widget.friendWish.content,
                                                  textAlign: TextAlign.start,
                                                  style: const TextStyle(
                                                    color: AppColors.font,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                  maxLines: 3,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                  flex: 4,
                                  child: widget.friendWish.status == 'pending'
                                      ? Row(
                                          children: [
                                            Spacer(),
                                            Expanded(
                                              child: ElevatedButton(
                                                onPressed: () async {
                                                  var response = await AppRequest()
                                                      .agreeOrRejectWish(
                                                          widget.friendWish,
                                                          'accepted');
                                                  if (response['code'] ==
                                                      '000001') {
                                                    setState(() {
                                                      widget.friendWish.read='true';
                                                      widget.friendWish.status =
                                                          'accepted';
                                                    });
                                                  }
                                                },
                                                style:

                                                ElevatedButton.styleFrom(
                                                  backgroundColor:AppColors.appBackground,
                                                  shape:
                                                       const RoundedRectangleBorder(
                                                    side: BorderSide(
                                                        width: 0.50,
                                                        color: AppColors.borderSideColor),
                                                    borderRadius: BorderRadius.all(
                                                        Radius.circular(6)),
                                                  ),

                                                )
                                                ,
                                                child: const Text(
                                                  AppStrings.agree,
                                                  style: TextStyle(
                                                    color: AppColors.font2,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: ElevatedButton(
                                                onPressed: () async {
                                                  var response = await AppRequest()
                                                      .agreeOrRejectWish(
                                                          widget.friendWish,
                                                          'rejected');
                                                  if (response['code'] ==
                                                      '000001') {
                                                    setState(() {
                                                      widget.friendWish.read='true';
                                                      widget.friendWish.status =
                                                          'rejected';
                                                    });
                                                  }
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:AppColors.appBackground,
                                                  shape: RoundedRectangleBorder(
                                                    side: const BorderSide(
                                                        width: 0.48,
                                                        color: AppColors.borderSideColor),
                                                    borderRadius:
                                                        BorderRadius.circular(9),
                                                  ),
                                                ),
                                                child: const Text(
                                                  AppStrings.refuse,
                                                  style: TextStyle(
                                                    color: AppColors.font2,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                          ],
                                        )
                                      : widget.friendWish.status == 'accepted'
                                          ? Row(
                                              children: [
                                                Spacer(),
                                                Container(
                                                  height: 40,
                                                  width: 150,
                                                  decoration:
                                                      AppStyle.btnShapeDecoration,
                                                  child: const Center(
                                                      child: Text(
                                                    '已同意',
                                                    style: TextStyle(
                                                        color: AppColors.font2,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )),
                                                ),
                                                SizedBox(
                                                  width: 12,
                                                )
                                              ],
                                            )
                                          : Row(
                                              children: [
                                                Spacer(),
                                                Container(
                                                  height: 40,
                                                  width: 150,
                                                  decoration:
                                                      AppStyle.btnShapeDecoration,
                                                  child: const Center(
                                                      child: Text(
                                                    '已拒绝',
                                                    style: TextStyle(
                                                        color: AppColors.font2,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )),
                                                ),
                                                SizedBox(
                                                  width: 12,
                                                )
                                              ],
                                            ))
                            ],
                          ),
                        ),
                        widget.friendWish.read=='false'?const Positioned(
                            top: 0,right: 0,
                            child: CircleAvatar(radius: 5,backgroundColor: Colors.red,)):Container()
                      ],
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      children: [
                        Container(
                          height: 356,
                          decoration: const BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.shadowColor,
                                blurRadius: 10,
                                offset: Offset(0, 2),
                                spreadRadius: 0,
                              )
                            ],
                            borderRadius: BorderRadius.all(Radius.circular(6)),
                          ),
                          child: Column(
                            children: [
                              Expanded(
                                flex: 200,
                                child: ClipRRect(
                                    borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(6)),
                                    child: GestureDetector(
                                        onTap: () {
                                          showDialog<void>(
                                            context: context,
                                            barrierColor: AppColors.black,
                                            builder: (BuildContext dialogContext) {
                                              return ZoomableImage(
                                                imageUrl:
                                                    widget.friendWish.wish_pics,
                                              );
                                            },
                                          );
                                        },
                                        child: Image.network(
                                          widget.friendWish.wish_pics,
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                          height: double.infinity,
                                        ))),
                              ),
                              Expanded(
                                flex: 170,
                                child: Container(
                                  padding: const EdgeInsets.only(
                                      top: 10, left: 4, right: 4, bottom: 8),
                                  clipBehavior: Clip.antiAlias,
                                  decoration:  const ShapeDecoration(
                                    color: AppColors.appBackground,
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          width: 0.48, color: AppColors.borderSideColor),
                                      borderRadius: BorderRadius.vertical(
                                          bottom: Radius.circular(6)),
                                    ),
                                    shadows: [
                                      BoxShadow(
                                        color: AppColors.shadowColor,
                                        blurRadius: 10,
                                        offset: Offset(0, 2),
                                        spreadRadius: 0,
                                      )
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Row(
                                          children: [
                                            const SizedBox(
                                              width: 15,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                if (myThem.portrait == null ||
                                                    myThem.portrait == '') {
                                                  appShowToast('对方未设置头像');
                                                } else {
                                                  showDialog<void>(
                                                    context: context,
                                                    barrierColor: Colors.black,
                                                    builder: (BuildContext
                                                        dialogContext) {
                                                      return ZoomableImage(
                                                        imageUrl: myThem.portrait!,
                                                      );
                                                    },
                                                  );
                                                }
                                              },
                                              child: Portrait(
                                                  size: 18,
                                                  userUid: widget
                                                      .friendWish.subject_useruid,
                                                  imgUrl: myThem.portrait == ''
                                                      ? null
                                                      : myThem.portrait),
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            Text(
                                              myThem.username!,
                                              style:  const TextStyle(
                                                color: AppColors.font,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Container(
                                              width: 40,
                                              height: 15,
                                              decoration: ShapeDecoration(
                                                color: AppColors.black,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(3)),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  gap,
                                                  style: const TextStyle(
                                                    color: AppColors.white,
                                                    fontSize: 7,
                                                    fontWeight: FontWeight.w800,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Spacer(),
                                            PopupMenuButton(
                                                onSelected: (value) async {
                                              switch (value) {
                                                case 0:
                                                  showFlexibleBottomSheet(
                                                    bottomSheetColor:const Color(0x00000000),
                                                    builder:
                                                        _buildBottomSheetUserInfo,
                                                    context: context,
                                                    minHeight: 0,
                                                    maxHeight: 0.93,
                                                    initHeight: 0.93,
                                                    anchors: [0, 0.93],
                                                    isExpand: true,
                                                  );
                                                  break;
                                                case 1:
                                                  if (widget.friendWish.status ==
                                                      'pending') {
                                                    var response =
                                                        await AppRequest()
                                                            .agreeOrRejectWish(
                                                                widget.friendWish,
                                                                'invisible');
                                                    if (response['code'] ==
                                                        '000001') {
                                                      setState(() {
                                                        widget.friendWish.status =
                                                            'invisible';
                                                      });
                                                      updateBox();
                                                    } else {
                                                      appShowToast('网络连接错误，请稍后重试');
                                                    }
                                                  } else {
                                                    appShowToast('您已表态的愿望不可被删除哦');
                                                  }
                                                  break;
                                                default:
                                              }
                                            }, itemBuilder: (context) {
                                              return [
                                                const PopupMenuItem(
                                                    value: 0,
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          '许愿人详情',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                        Spacer(),
                                                        Icon(
                                                          Icons.handshake_outlined,
                                                          color: Colors.black,
                                                        )
                                                      ],
                                                    )),
                                                const PopupMenuItem(
                                                  value: 1,
                                                  child: Row(children: [
                                                    Text('删除',
                                                        style: TextStyle(
                                                            color: Colors.red)),
                                                    Spacer(),
                                                    Icon(
                                                      Icons.delete_forever_outlined,
                                                      color: Colors.red,
                                                    )
                                                  ]),
                                                ),
                                              ];
                                            })
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Container(
                                          width: double.infinity,
                                          padding: const EdgeInsets.only(
                                              left: 25,
                                              right: 25,
                                              bottom: 5,
                                              top: 5),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  widget.friendWish.content,
                                                  textAlign: TextAlign.start,
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                          flex: 1,
                                          child: widget.friendWish.status ==
                                                  'pending'
                                              ? Row(
                                                  children: [
                                                    Spacer(),
                                                    Expanded(
                                                      child: ElevatedButton(
                                                        onPressed: () async {
                                                          var response =
                                                              await AppRequest()
                                                                  .agreeOrRejectWish(
                                                                      widget
                                                                          .friendWish,
                                                                      'accepted');
                                                          if (response['code'] ==
                                                              '000001') {
                                                            setState(() {
                                                              widget.friendWish.read='true';
                                                              widget.friendWish
                                                                      .status =
                                                                  'accepted';
                                                            });
                                                          }
                                                        },
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          backgroundColor:
                                                              AppColors.appBackground,
                                                          shape:
                                                              const RoundedRectangleBorder(
                                                            side: BorderSide(
                                                                width: 0.50,
                                                                color: AppColors.borderSideColor),
                                                            borderRadius:
                                                                BorderRadius.all(
                                                                    Radius.circular(
                                                                        6)),
                                                          ),
                                                        ),
                                                        child: const Text(
                                                          AppStrings.agree,
                                                          style: TextStyle(
                                                            color: AppColors.font2,
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Expanded(
                                                      child: ElevatedButton(
                                                        onPressed: () async {
                                                          var response =
                                                              await AppRequest()
                                                                  .agreeOrRejectWish(
                                                                      widget
                                                                          .friendWish,
                                                                      'rejected');
                                                          if (response['code'] ==
                                                              '000001') {
                                                            setState(() {
                                                              widget.friendWish.read='true';
                                                              widget.friendWish
                                                                      .status =
                                                                  'rejected';
                                                            });
                                                          }
                                                        },
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          backgroundColor:AppColors.appBackground,
                                                          shape:
                                                              const RoundedRectangleBorder(
                                                            side: BorderSide(
                                                                width: 0.50,
                                                                color: AppColors.borderSideColor),
                                                            borderRadius:
                                                                BorderRadius.all(
                                                                    Radius.circular(
                                                                        6)),
                                                          ),
                                                        ),
                                                        child: const Text(
                                                          AppStrings.refuse,
                                                          style: TextStyle(
                                                            color: AppColors.font2,
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                  ],
                                                )
                                              : widget.friendWish.status ==
                                                      'accepted'
                                                  ? Row(
                                                      children: [
                                                        Spacer(),
                                                        Container(
                                                          height: 40,
                                                          width: 150,
                                                          decoration: AppStyle
                                                              .btnShapeDecoration,
                                                          child: const Center(
                                                              child: Text(
                                                            '已同意',
                                                            style: TextStyle(
                                                                color:
                                                                    AppColors.font2,
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          )),
                                                        ),
                                                        SizedBox(
                                                          width: 12,
                                                        )
                                                      ],
                                                    )
                                                  : Row(
                                                      children: [
                                                        Spacer(),
                                                        Container(
                                                          height: 40,
                                                          width: 150,
                                                          decoration: AppStyle
                                                              .btnShapeDecoration,
                                                          child: const Center(
                                                              child: Text(
                                                            '已拒绝',
                                                            style: TextStyle(
                                                                color:
                                                                    AppColors.font2,
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          )),
                                                        ),
                                                        SizedBox(
                                                          width: 12,
                                                        )
                                                      ],
                                                    ))
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        widget.friendWish.read=='false'?const Positioned(
                            top: 0,right: 0,
                            child: CircleAvatar(radius: 5,backgroundColor: Colors.red,)):Container()
                      ],
                    ),
                  );
          }
        } else {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                Container(
                  height: widget.friendWish.wish_pics != '' ? 356 : 200,
                  width: double.infinity,
                  decoration: AppStyle.boxDecoration,
                  child: const Center(
                    child: Padding(
                      padding: EdgeInsets.all(40.0),
                      child: CircularProgressIndicator(
                        color: AppColors.bottomNvAndLoading,
                      ),
                    ),
                  ),
                ),
                widget.friendWish.read=='false'?const Positioned(
                    top: 0,right: 0,
                    child: CircleAvatar(radius: 5,backgroundColor: Colors.red,)):Container()
              ],
            ),
          );
        }
      },
    );
  }

  Future getUserData() {
    return Future(() async {
      myThem =
          await AppRequest().getUserInfo(widget.friendWish.subject_useruid);
      if(widget.friendWish.read=='false'){
        var response = await AppRequest().readWish(widget.friendWish);
      }
    });
  }

  Widget _buildBottomSheetUserInfo(
    BuildContext context,
    ScrollController scrollController,
    double bottomSheetOffset,
  ) {
    bool flag =
        widget.friendWish.subject_useruid != widget.friendWish.object_useruid;
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
            height:Get.height*0.89,
            child: Column(
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
                const SizedBox(
                  height: 50,
                ),
                InkWell(
                  onTap: () {
                    if (myThem.portrait == null) {
                      appShowToast('对方未设置头像');
                    } else {
                      showDialog<void>(
                        context: context,
                        barrierColor: AppColors.black,
                        builder: (BuildContext dialogContext) {
                          return ZoomableImage(
                            imageUrl: myThem.portrait!,
                          );
                        },
                      );
                    }
                  },
                  child: Portrait(
                    size: 75,
                    userUid: widget.friendWish.subject_useruid,
                    imgUrl: myThem.portrait,
                  ),
                ),
                SizedBox(
                  height: 25,
                ),

                Text(
                  myThem.username!,
                  textAlign: TextAlign.center,
                  style:  TextStyle(
                    color: AppColors.font,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Expanded(
                    flex: 4,
                    child: FriendWannaListViewComponent(myThem: myThem)),
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
                        child: flag
                            ? Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SizedBox(height: 12),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      const Text('我向Ta许过的愿望'),
                                      Text('${myThem.numMyWishTo}')
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      const Text('Ta帮我实现的愿望'),
                                      Text('${myThem.numMyWishThemDone}')
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      const Text('Ta向我许过的愿望'),
                                      Text('${myThem.numTheirWishToMe}')
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      const Text('我帮Ta实现的愿望'),
                                      Text('${myThem.numTheirWishMeDone}')
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  )
                                ],
                              )
                            : Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                    const SizedBox(height: 12),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        const Text('我向自己许过的愿望'),
                                        Text('${myThem.numMyWishTo}')
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        const Text('我帮自己实现的愿望'),
                                        Text('${myThem.numMyWishThemDone}')
                                      ],
                                    ),
                                    SizedBox(
                                      height: 12,
                                    )
                                  ]),
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
                        if (widget.friendWish.subject_useruid !=
                            widget.friendWish.object_useruid) {
                          var text = '确定要将该用户加入黑名单吗？';
                          Map friendUidAndRidMap =
                              boxAccount.read('friend_uid_map');
                          List friendUidList = friendUidAndRidMap.keys.toList();
                          bool flag = friendUidList.contains(
                              widget.friendWish.subject_useruid.toString());
                          int? relationId;
                          if (flag) {
                            text = '对方是您的好友，此操作会解除与对方的好友关系，确定要将对方加入黑名单吗？';
                            relationId = friendUidAndRidMap[
                                widget.friendWish.subject_useruid.toString()];
                          }
                          appShowDialog(context, '加入黑名单', text, '取消', '确认',
                              () async {
                            showLoading();
                            if (flag) {//数据库操作
                              var token = boxAccount.read('token');//获取当前密匙
                              print(token);
                              Dio dio = AppRequestType().getDioWithToken(token);
                              var response = await dio.delete('/users/relations',
                                  data: {"relation_uid": relationId});//操作移除好友
                              if (response.data['code'] == '000001') {
                                var test = await AppRequest()//请求后台获取id
                                    .getFriends(boxAccount.read('user_uid'));
                                boxFriend.write('them', test); //将id加入them
                              }
                            }

                            //拉黑操作不操作收愿箱信息，只操作可见？
                            var res = await AppRequest()
                                .addBlock(widget.friendWish.subject_useruid);
                            if (res['code'] == '000001') {
                              Get.back();
                              Get.offAll(
                                  () => const HomePage(menus: Menus.wishList));
                              appShowToast('拉黑成功');//appShowToast：一个持续一会的小框
                              print(await AppRequest().queryBlockList());
                            } else {
                              appShowToast('未知错误');
                            }
                          });
                        } else {
                          appShowToast('无法将自己加入黑名单');
                        }
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
                        '加入黑名单',
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

  getGap() {
    final now = DateTime.now();
    final postDate = DateTime.parse(widget.friendWish.pub_date);
    String theGap;
    if (now.difference(postDate).inSeconds < 60) { //时间相减操作
      theGap = '刚刚';
    } else if (now.difference(postDate).inMinutes < 60) {
      theGap = '${now.difference(postDate).inMinutes}分钟前';
    } else if (now.difference(postDate).inHours < 24) {
      theGap = '${now.difference(postDate).inHours}小时前';
    } else if (now.difference(postDate).inDays < 30) {
      theGap = '${now.difference(postDate).inDays}天前';
    } else if ((now.year-postDate.year)*12+(now.month-postDate.month)<12) {
      theGap = '${(now.year-postDate.year)*12+(now.month-postDate.month)}个月前';
    } else {
      theGap = '${now.year - postDate.year}年前';
    }

    return theGap;
  }
}

class ZoomableImage extends StatefulWidget {
  const ZoomableImage({super.key, required this.imageUrl});
  final String imageUrl;

  @override
  State<ZoomableImage> createState() => _ZoomableImageState();
}

class _ZoomableImageState extends State<ZoomableImage> {
  final ValueNotifier<PhotoViewController> controller =
      ValueNotifier<PhotoViewController>(PhotoViewController());
  final ValueNotifier<double> scaleNotifier = ValueNotifier(1.0);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.back();
      },
      child: Stack(
        children: [
          PhotoView(
            imageProvider: NetworkImage(widget.imageUrl),
            scaleStateController: PhotoViewScaleStateController(),
            controller: controller.value,
            backgroundDecoration: const BoxDecoration(color: AppColors.black),
            minScale: PhotoViewComputedScale.contained * 0.8,
            maxScale: PhotoViewComputedScale.covered * 2,
            enableRotation: true,
          ),
          Positioned(
              top: 0,
              right: 0,
              child: IconButton(
                onPressed: () async {
                  final appDocDir = await getApplicationDocumentsDirectory();//获取权限位置
                  String downloadPath =
                      '${appDocDir.path}/wowow/${DateTime.now()}.jpg';
                  Navigator.pop(context); // 关闭菜单
                  var response =
                      await Dio().download(widget.imageUrl, downloadPath);
                  final result = await ImageGallerySaver.saveFile(downloadPath,
                      name: 'WoWoW');//图片存储到手机上
                  print(result);
                  if (result['isSuccess']) {
                    appShowToast('已保存至图库');//会退出照片界面
                  }
                },
                icon: Icon(
                  size: 30,
                  Icons.download,
                  color: AppColors.white,
                ),
              )),
        ],
      ),
    );
  }
}

class ZoomableImageFromFile extends StatefulWidget {
  const ZoomableImageFromFile({super.key, required this.image});
  final File image;

  @override
  State<ZoomableImageFromFile> createState() => _ZoomableImageFromFileState();
}

class _ZoomableImageFromFileState extends State<ZoomableImageFromFile> {
  final ValueNotifier<PhotoViewController> controller =
      ValueNotifier<PhotoViewController>(PhotoViewController());
  final ValueNotifier<double> scaleNotifier = ValueNotifier(1.0);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.back();
      },
      child: PhotoView(
        imageProvider: FileImage(widget.image),
        scaleStateController: PhotoViewScaleStateController(),
        controller: controller.value,
        backgroundDecoration: const BoxDecoration(color: AppColors.black),
        minScale: PhotoViewComputedScale.contained * 0.8,
        maxScale: PhotoViewComputedScale.covered * 2,
        enableRotation: true,
      ),
    );
  }
}
