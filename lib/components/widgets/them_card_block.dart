import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:wowowwish/components/widgets/portrait.dart';
import 'package:wowowwish/components/widgets/post_item_from_friend.dart';
import 'package:wowowwish/components/widgets/them_card.dart';
import 'package:wowowwish/constants.dart';
import 'package:wowowwish/model/block.dart';
import 'package:wowowwish/model/them.dart';
import 'package:wowowwish/request/requests.dart';

import '../../config/app_toast.dart';
import '../../styles/app_colors.dart';
import '../../styles/app_style.dart';

class BlockThemCard extends StatefulWidget {
  const BlockThemCard({super.key, required this.blockWithoutThem});
  final Block blockWithoutThem;
  @override
  State<BlockThemCard> createState() => _BlockThemCardState();
}

class _BlockThemCardState extends State<BlockThemCard> {
  bool flag=true;
  late Block block;
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
    return flag?Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 6),
      child: FutureBuilder(
          future: getData(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Container(
                    clipBehavior: Clip.antiAlias,
                    width: double.infinity,
                    height: 80,
                    decoration: ShapeDecoration(
                      color: AppColors.secondary,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 0.97, color: AppColors.borderSideColor),
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.error_outline),
                        SizedBox(
                          width: 10,
                        ),
                        Text('加载失败')
                      ],
                    ));
              } else {
                return GestureDetector(
                  onTap: (){
                    showFlexibleBottomSheet(
                      bottomSheetColor: const Color(0x00FFFFFF),
                      builder: _buildBottomSheetHeader,
                      context: context,
                      minHeight: 0,
                      maxHeight: 0.93,
                      initHeight: 0.93,
                      anchors: [0, 0.93],
                      isExpand: true,
                      isDismissible: false
                      // isSafeArea: true
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    height: 80,
                    padding: const EdgeInsets.only(
                      top: 5,
                      left: 18,
                      bottom: 5,
                      right: 25
                    ),
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      color: AppColors.appBackground,
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(width: 0.97, color: AppColors.borderSideColor),
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Portrait(size: 22, userUid: block.userUid,imgUrl: block.myThem!.portrait,),
                        SizedBox(width: 15,),
                        Text(block.myThem!.username!,
                          style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),),
                        const Spacer(),
                        const Icon(Icons.chevron_right),
                      ],
                    ),
                  ),
                );
              }
            } else {
              return Container(
                  width: double.infinity,
                  height: 80,
                  padding: const EdgeInsets.only(
                    top: 18,
                    left: 18,
                    right: 23,
                    bottom: 18,
                  ),
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    color: AppColors.appBackground,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 0.97, color: AppColors.borderSideColor),
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Center(child: CircularProgressIndicator()));
            }
          }),
    ):Container();
  }
  Widget _buildBottomSheetHeader(
      BuildContext context,
      ScrollController scrollController,
      double bottomSheetOffset,
      ) {
    return Container(
      height: 1000,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
        color: AppColors.appBackground,
      ),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: SingleChildScrollView(
          controller: scrollController,
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
              SizedBox(
                height: 50,
              ),
              GestureDetector(
                onTap: (){
                  if(block.myThem!.portrait!=null){
                    showDialog<void>(
                      context: context,
                      barrierColor: AppColors.black,
                      builder: (BuildContext dialogContext) {
                        return ZoomableImage(
                          imageUrl: block.myThem!.portrait!,
                        );
                      },
                    );
                  }else{
                    appShowToast('对方未设置头像');
                  }
                },
                child: Portrait(
                  size: 75,
                  userUid: widget.blockWithoutThem.userUid,
                  imgUrl: block.myThem!.portrait,
                ),
              ),
              SizedBox(
                height: 13,
              ),
              SizedBox(
                height: 9,
              ),
              Text(
                block.myThem!.username!,
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
              FriendWannaListViewComponent(myThem: block.myThem!),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 355,
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
                            Text('${block.myThem!.numMyWishTo}')
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text('Ta帮我实现的愿望'),
                            Text('${block.myThem!.numMyWishThemDone}')
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text('Ta向我许过的愿望'),
                            Text('${block.myThem!.numTheirWishToMe}')
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text('我帮Ta实现的愿望'),
                            Text('${block.myThem!.numTheirWishMeDone}')
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
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 355,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () async {
                      var response= await AppRequest().deleteBlockUser(widget.blockWithoutThem.blockId);
                      if(response['code']=='000001'){
                        Get.back();
                        setState(() {
                          flag=false;
                        });
                        appShowToast('移除成功');
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
                      '移出黑名单',
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
    );
  }
  getData() async {
    MyThem myThem=await AppRequest().getUserInfo(widget.blockWithoutThem.userUid);
    block = Block(widget.blockWithoutThem.blockId, widget.blockWithoutThem.userUid,widget.blockWithoutThem.dateTime);
    block.setMyThem(myThem);
    print(await AppRequest().queryBlockList());
  }
}
