import 'dart:io';

import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wowowwish/components/widgets/post_item_from_friend.dart';
import 'package:wowowwish/config/app_toast.dart';
import 'package:wowowwish/constants.dart';
import 'package:wowowwish/request/requests.dart';
import 'package:wowowwish/styles/app_colors.dart';
import '../../model/wish.dart';
import '../../routes/app_routes.dart';
import '../../styles/app_style.dart';

class MyWishCard extends StatefulWidget {
  const MyWishCard({
    super.key,
    required this.wish,
  });
  final Wish wish;
  static const Map map = {
    'accepted': '已同意',
    'rejected': '已拒绝',
  };

  @override
  State<MyWishCard> createState() => _MyWishCardState();
}

class _MyWishCardState extends State<MyWishCard> {
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
                child: CircularProgressIndicator(color: AppColors.bottomNvAndLoading,),
              )),
        ),
        barrierDismissible: false);
  }

  void hideLoading() {
    isLoading.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return widget.wish.status == 'invisible'
        ? Container()
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                showFlexibleBottomSheet(
                  bottomSheetColor: Color(0x00FFFFFF),
                  builder: _buildBottomSheetWishInfo,
                  context: context,
                  minHeight: 0,
                  maxHeight: 0.93,
                  initHeight: 0.93,
                  anchors: [0, 0.93],
                  isExpand: true,
                );
              },
              child: Container(
                width: 361,
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  color:  AppColors.appBackground,
                  shape: RoundedRectangleBorder(
                    side:
                        const BorderSide(width: 0.50, color: AppColors.borderSideColor),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  shadows:  [
                    BoxShadow(
                      color: AppColors.shadowColor,
                      blurRadius: 10,
                      offset: Offset(0, 2),
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 11,
                        child: SizedBox(
                          width: 351,
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  widget.wish.content,
                                  style: const TextStyle(
                                    color: AppColors.black,
                                    fontSize: 14,

                                    fontWeight: FontWeight.w600,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        flex: 2,
                        child: widget.wish.status == 'pending'
                            ? const SizedBox(
                                width: 50,
                                height: 20,
                              )
                            : Container(
                                width: 50,
                                height: 20,
                                padding: const EdgeInsets.only(
                                    top: 2, left: 4, right: 4, bottom: 1),
                                clipBehavior: Clip.antiAlias,
                                decoration: ShapeDecoration(
                                  color: widget.wish.status == 'accepted'
                                      ? const Color(0xFF98BC73)
                                      : const Color(0xFF414141),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                ),
                                child: Text(
                                  MyWishCard.map[widget.wish.status],
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,

                                    fontWeight: FontWeight.w600,
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
    // return Row(
    //   children: [
    //   Text(
    //   postText,
    //   textAlign: TextAlign.center,
    //   style: const TextStyle(
    //     color: Color(0xFF161616),
    //     fontSize: 12,
    //      'San Francisco Display',
    //     fontWeight: FontWeight.w600,
    //   ),
    //   maxLines: 3,
    //   overflow: TextOverflow.ellipsis,),
    //     Container(
    //
    //     )
    //   ],
    // );
  }

  Widget _buildBottomSheetWishInfo(
    BuildContext context,
    ScrollController scrollController,
    double bottomSheetOffset,
  ) {
    String gap = getGap();
    return Container(
      height: Get.height*0.93,
      width: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
        color: AppColors.appBackground,
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 14.0,right: 14.0,top: 14),
        child: SingleChildScrollView(
          controller: scrollController,
          child: SizedBox(
            height: Get.height*0.89,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                const Spacer(),
                Expanded(
                  flex: 15,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                widget.wish.content,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: AppColors.font2,
                                  fontSize: 20,

                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 22,),
                        widget.wish.wish_pics!=''?
                        GestureDetector(
                          onTap: (){
                            showDialog<void>(
                              context: context,
                              barrierColor: AppColors.black,
                              builder: (BuildContext dialogContext) {
                                return ZoomableImage(
                                  imageUrl: widget.wish.wish_pics,
                                );
                              },
                            );
                          },
                          child: Container(
                            width: 244,
                            height: 160,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(widget.wish.wish_pics),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ):Container(),
                        SizedBox(height: 50,),
                        Text(
                          gap,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: AppColors.hintColor,
                            fontSize: 14,

                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 10,),
                        widget.wish.status == 'pending'
                            ? const SizedBox(
                          width: 50,
                          height: 20,
                        )
                            : Container(
                          width: 50,
                          height: 20,
                          padding: const EdgeInsets.only(
                              top: 2, left: 4, right: 4, bottom: 1),
                          clipBehavior: Clip.antiAlias,
                          decoration: ShapeDecoration(
                            color: widget.wish.status == 'accepted'
                                ? const Color(0xFF98BC73)
                                : const Color(0xFF414141),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                          ),
                          child: Text(
                            MyWishCard.map[widget.wish.status],
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,

                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: (){
                            Get.toNamed(Routes.WISHSHARE,arguments: widget.wish.toMap());
                            //todo:分享愿望
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.appBackground,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                              side: const BorderSide(
                                  width: 1,
                                  color: AppColors.borderSideColor
                              ),
                              shadowColor: const Color(0x00000000)
                          ),
                          child:  const Row(
                            children: [
                              Text(
                                '分享愿望',
                                textAlign: TextAlign.center,
                                style:TextStyle(
                                  color:AppColors.font2,
                                  fontSize: 14,

                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Spacer(),
                              Icon(Icons.share,color: AppColors.font2,size: 23,)
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: ()  async {
                            if(widget.wish.status!='accepted'&&widget.wish.status!='rejected'){
                              var response = await AppRequest()
                                  .agreeOrRejectWish(widget.wish, 'invisible');
                              if (response['code'] == '000001') {
                                showLoading();
                                await updateBox();
                                hideLoading();
                                appShowToast('撤回成功');
                                Get.back();
                                Get.back();
                                setState(() {
                                  widget.wish.status = 'invisible';
                                });
                              }
                            }else{
                              appShowToast('该愿望对方已经作出处理，无法撤回了哦');
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.appBackground,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                            side: const BorderSide(
                              width: 1,
                              color: AppColors.borderSideColor
                            ),
                            shadowColor: const Color(0x00000000)
                          ),
                          child:  const Row(
                            children: [
                              Text(
                                '撤回',
                                textAlign: TextAlign.center,
                                style:TextStyle(
                                  color: Color(0xFFE34949),
                                  fontSize: 14,

                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Spacer(),
                              Icon(Icons.undo,color: Color(0xFFE34949),size: 23,)
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: (){
                            if(widget.wish.status=='pending'){
                              showDialog<void>(
                                context: context,
                                barrierDismissible: true,
                                // false = user must tap button, true = tap outside dialog
                                builder: (BuildContext dialogContext) {
                                  return AlertDialog(
                                    title: const Text('重新编辑'),
                                    actions: <Widget>[
                                      ReSendCard(
                                        wish: widget.wish,
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                            else{
                              appShowToast('该愿望对方已经作出处理，无法编辑了哦');
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.appBackground,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                              side: const BorderSide(
                                  width: 1,
                                  color: AppColors.borderSideColor
                              ),
                              shadowColor: const Color(0x0)
                          ),
                          child:  const Row(
                            children: [
                              Text(
                                '重新编辑',
                                textAlign: TextAlign.center,
                                style:TextStyle(
                                  color: AppColors.font2,
                                  fontSize: 14,

                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Spacer(),
                              Icon(Icons.edit_note_outlined,color: AppColors.font2,size: 25,)
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  getGap() {
    final now = DateTime.now();
    final postDate = DateTime.parse(widget.wish.pub_date);
    String theGap;
    if (now.difference(postDate).inSeconds < 60) {
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

class ReSendCard extends StatefulWidget {
  const ReSendCard({super.key, required this.wish});
final Wish wish;
  @override
  State<ReSendCard> createState() => _ReSendCardState();
}

class _ReSendCardState extends State<ReSendCard> {
  File? imageSelect;
  bool flag = false;
  late String content;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const ShapeDecoration(
        color: AppColors.appBackground,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 0.48, color: AppColors.borderSideColor),
          borderRadius: BorderRadius.all(Radius.circular(16)),
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
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              cursorColor: Colors.grey,
              onChanged: (value) {
                content=value;
              },
              decoration: const InputDecoration(
                hintText: '请输入愿望内容',
                border: InputBorder.none,
                filled: true,
                fillColor: AppColors.appBackground,
              ),
              maxLength: 40,
              maxLines: 3,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Stack(
                  children: [
                    SizedBox(
                      height: 60,
                      width: 60,
                      child: imageSelect==null
                          ? IconButton(
                              onPressed: () async {
                                PermissionStatus status =await Permission.photos.status;
                                if(!status.isGranted){
                                  status = await Permission.photos.request();
                                }
                                final ImagePicker imagePicker = ImagePicker();
                                XFile? image1 = await imagePicker.pickImage(
                                    source: ImageSource.gallery,
                                    maxHeight: 1080,
                                    maxWidth: 1080
                                );
                                if (image1 != null) {
                                  setState(() {
                                    imageSelect=File(image1.path);
                                  });
                                }else{
                                  appShowToast('已取消');
                                }
                              },
                              icon: const Icon(
                                Icons.add_photo_alternate_outlined,
                                size: 50,
                              ))
                          :Container(
                            width: 50,
                            height: 50,
                            clipBehavior: Clip.antiAlias,
                            decoration: ShapeDecoration(
                              image: DecorationImage(
                                image: FileImage(imageSelect!),
                                fit: BoxFit.fill,
                              ),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
                            ),
                          ),
                    ),

                    imageSelect!=null
                        ?Positioned(
                      top: 0,
                      right: 0,
                      child:GestureDetector(
                          onTap: (){
                            setState(() {
                              imageSelect=null;
                            });
                          },
                          child: const Icon(Icons.cancel,color: Colors.grey,size: 16,)) ,
                    )
                        :Container(),
                  ],
                ),
                Spacer(),
                Row(crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        PermissionStatus status =await Permission.camera.status;
                        if(!status.isGranted){
                          status = await Permission.camera.request();
                        }
                        final ImagePicker imagePicker =
                        ImagePicker();
                        XFile? image1 =
                        await imagePicker.pickImage(
                            source: ImageSource.camera,
                            maxHeight: 1080,
                            maxWidth: 1080
                        );
                        if (image1 != null) {
                          setState(() {
                            imageSelect =
                                File(image1.path);
                          });
                        } else {
                          appShowToast('已取消');
                        }
                      },
                      child:  const Icon(
                        Icons.camera_alt_outlined,
                        size: 20,
                      ),
                    ),
                    SizedBox(width: 10,),
                    GestureDetector(
                      onTap: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                      },
                      child: const Icon(
                        Icons.keyboard_hide_outlined,
                        size: 20,
                      ),
                    ),
                    SizedBox(width: 10,),
                    SizedBox(
                      height: 30,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.appBackground,
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  width: 0.10, color: AppColors.borderSideColor),
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                          onPressed: () async {
                            showLoading();
                            var picUrl=imageSelect==null?null:imageSelect!.path;
                            await onSend(picUrl);
                            hideLoading();
                          }, child: const Text('发送',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.bottomNvAndLoading,
                        fontSize: 12,

                        fontWeight: FontWeight.w600,
                        height: 0,
                      ),)),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(height: 6,)
          ],
        ),
      ),
    );
  }
  RxBool isLoading = false.obs;
  onSend(String? pickImg) async {
    if(content!=''){
      var response = await AppRequest()
          .editWish(widget.wish, content, pickImg);
      if (response['code'] == '000001') {
        appShowToast('编辑成功');
        Get.offAllNamed(Routes.HOME);
      } else {
        appShowToast('编辑失败，请检查网络或稍后重试。');
        Get.back();
      }
    }else{
      appShowToast('愿望内容不能为空');
      Get.back();
    }
  }
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
                child: CircularProgressIndicator(color: AppColors.bottomNvAndLoading,),
              )),
        ),
        barrierDismissible: false);
  }
  void hideLoading() {
    isLoading.value = false;
  }
}
