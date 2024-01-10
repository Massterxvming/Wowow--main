import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:wowowwish/components/widgets/post_item_from_friend.dart';
import 'package:wowowwish/config/app_toast.dart';
import 'package:wowowwish/constants.dart';
import 'package:wowowwish/request/requests.dart';
import 'package:wowowwish/styles/app_style.dart';

import '../../model/wanna.dart';
import '../../styles/app_colors.dart';

class MyWannaCard extends StatefulWidget {
  const MyWannaCard({super.key, required this.myWanna});
  final Wanna myWanna;

  @override
  State<MyWannaCard> createState() => _MyWannaCardState();
}

class _MyWannaCardState extends State<MyWannaCard> {
  bool flag=true;
  @override
  Widget build(BuildContext context) {
    return flag?
        Padding(padding: const EdgeInsets.all(9),
        child: widget.myWanna.wannaPics != ""
            ? Container(
            width: double.infinity,
            height: 356,
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: AppColors.shadowColor,
                blurRadius: 10,
                offset: Offset(0, 2),
                spreadRadius: 0,
              )
            ],
            color: AppColors.appBackground,
            borderRadius: BorderRadius.all(Radius.circular(12)),

          ),
          child: Column(
            children: [
              Expanded(
                  child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
                      child: GestureDetector(onTap:(){
                        FocusScope.of(context).requestFocus(FocusNode());
                        showDialog<void>(
                          context: context,
                          barrierColor: AppColors.black,
                          builder: (BuildContext dialogContext) {
                            return ZoomableImage(imageUrl: widget.myWanna.wannaPics,);
                          },
                        );
                      },child: CachedNetworkImage(
                        imageUrl: widget.myWanna.wannaPics,fit: BoxFit.cover,width: double.infinity,height: double.infinity,)))),
              Container(
                width: 361,
                height: 70,
                padding: const EdgeInsets.only(left: 15, right: 10),
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(
                  color: AppColors.appBackground,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        widget.myWanna.content,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          height: 0,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: 60,
                padding: const EdgeInsets.only(
                    left: 15, right: 10,bottom: 9,top: 9),
                clipBehavior: Clip.antiAlias,
                decoration:
                const BoxDecoration(color: AppColors.appBackground),
                child: widget.myWanna.status == 'ongoing'
                    ? Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Spacer(),
                    SizedBox(
                      width: 82,
                      height: 32,
                      child: ElevatedButton(
                        onPressed: () async {
                          try{setState(() {
                            widget.myWanna.status = 'done';
                          });
                          var result = await AppRequest()
                              .editWannaStatusDone(
                              widget.myWanna);
                          if (result['code'] == '000001') {
                            await updateWannaList(
                                boxAccount.read('user_uid'));
                          } else {
                            appShowToast('未知错误，更新失败');
                          }
                          }catch(e){
                            appShowToast('网络错误，操作失败');
                            setState(() {
                              widget.myWanna.status = 'ongoing';
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:AppColors.appBackground,
                          shape:
                          const RoundedRectangleBorder(
                            side: BorderSide(
                                width: 0.50,
                                color: AppColors.borderSideColor),
                            borderRadius: BorderRadius.all(
                                Radius.circular(6)),
                          ),
                        ),
                        child: const Text('完成',
                            style: TextStyle(
                                color: AppColors.font2,
                                fontSize: 12,
                                fontWeight: FontWeight.w600)),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 82,
                      height: 32,
                      child: ElevatedButton(
                        onPressed: () async{
                          setState(() {
                            flag=false;
                          });
                          var response = await AppRequest().deleteWanna(widget.myWanna);
                          if(response['code']=='000001'){
                            appShowToast('删除成功');
                            await updateWannaList(
                                boxAccount.read('user_uid'));
                          }else{
                            appShowToast('网络错误，删除失败');
                            setState(() {
                              flag=true;
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:AppColors.appBackground,
                          shape:
                          const RoundedRectangleBorder(
                            side: BorderSide(
                                width: 0.50,
                                color: AppColors.borderSideColor),
                            borderRadius: BorderRadius.all(
                                Radius.circular(6)),
                          ),
                          // shadowColor:
                        ),
                        child: const Text('删除',
                            style: TextStyle(
                                color: AppColors.font2,
                                fontSize: 12,
                                fontWeight: FontWeight.w600)),
                      ),
                    ),
                  ],
                )
                    : Row(
                  children: [
                    const Spacer(),
                    Container(
                      height: 40,
                      width: 150,
                      decoration: AppStyle.btnShapeDecoration,
                      child: const Center(
                          child: Text(
                            '已完成',
                            style: TextStyle(
                                color: AppColors.font2,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                  ],
                ),
              ),

            ],
          ),
        )
            : Container(
          width: 361,
          height: 120,
          padding: const EdgeInsets.only(top:10,left: 15, right: 10),
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            color: AppColors.appBackground,
            shape: RoundedRectangleBorder(
              side: const BorderSide(width: 0.50, color: AppColors.borderSideColor),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      widget.myWanna.content,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,

                        fontWeight: FontWeight.w600,
                        height: 0,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Container(
                width: double.infinity,
                height: 60,
                padding:
                const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(),
                child: widget.myWanna.status == 'ongoing'
                    ? Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Spacer(),
                    SizedBox(
                      width: 82,
                      height: 32,
                      child: ElevatedButton(
                        onPressed: () async {
                          try{setState(() {
                            widget.myWanna.status = 'done';
                          });
                          var result = await AppRequest()
                              .editWannaStatusDone(
                              widget.myWanna);
                          if (result['code'] == '000001') {
                            await updateWannaList(
                                boxAccount.read('user_uid'));
                          } else {
                            appShowToast('未知错误，更新失败');
                          }
                          }catch(e){
                            appShowToast('网络错误，操作失败');
                            setState(() {
                              widget.myWanna.status = 'ongoing';
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:AppColors.appBackground,
                          shape:
                          const RoundedRectangleBorder(
                            side: BorderSide(
                                width: 0.50,
                                color: AppColors.borderSideColor),
                            borderRadius: BorderRadius.all(
                                Radius.circular(6)),
                          ),
                        ),
                        child: const Text('完成',
                            style: TextStyle(
                              color: AppColors.font2,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,)),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 82,
                      height: 32,
                      child: ElevatedButton(
                        onPressed: () async{
                          setState(() {
                            flag=false;
                          });
                          var response = await AppRequest().deleteWanna(widget.myWanna);
                          if(response['code']=='000001'){
                            appShowToast('删除成功');
                            await updateWannaList(
                                boxAccount.read('user_uid'));
                          }else{
                            appShowToast('网络错误，删除失败');
                            setState(() {
                              flag=true;
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:AppColors.appBackground,
                          shape:
                          const RoundedRectangleBorder(
                            side: BorderSide(
                                width: 0.50,
                                color: AppColors.borderSideColor),
                            borderRadius: BorderRadius.all(
                                Radius.circular(6)),
                          ),
                        ),
                        child: const Text('删除',
                            style: TextStyle(
                              color: AppColors.font2,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,)),
                      ),
                    ),
                  ],
                )
                    : Row(
                  children: [
                    Spacer(),
                    Container(
                      height: 40,
                      width: 150,
                      decoration: AppStyle.btnShapeDecoration,
                      child: const Center(
                          child: Text(
                            '已完成',
                            style: TextStyle(
                                color: AppColors.font2,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                  ],
                ),
              )
            ],
          ),
        )
        )
      :Container();
  }
}
