import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../../components/widgets/app_tool_bar.dart';
import '../../../../../styles/app_colors.dart';
import '../../../../../styles/app_style.dart';
import '../../../../../utils/app_utils.dart';
import '../../../add_friend/logic.dart';
import 'logic.dart';

class WishSharePageSimple extends StatelessWidget {
  WishSharePageSimple({Key? key}) : super(key: key);

  final logic = Get.find<WishShareSimpleLogic>();
  final logicAddFriend = Get.find<AddFriendLogic>();
  final GlobalKey repaintWidgetKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    Color foregroundColor =logic.backgroundColor.computeLuminance()>0.5?Colors.black:Colors.white;
    return Scaffold(
      appBar: ToolBar(title: '分享愿望'),
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: SizedBox(
          height: Get.height-AppBar().preferredSize.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 25,
              ),
              Center(
                child: RepaintBoundary(
                  key: repaintWidgetKey,
                  child: Container(
                    width: 331.60,
                    height: 471.27,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                        color: logic.backgroundColor),
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0,
                          top: 0,
                          bottom: 0,
                          right: 0,
                          child: Padding(
                            padding: const EdgeInsets.all(25.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    '“${logic.wish.content}”',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color:foregroundColor,
                                      fontSize: 30,

                                      fontWeight: FontWeight.w600,
                                      height: 0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          left: 14,
                          top: 12,
                          child: SizedBox(
                            width: 150,
                            height: 90,
                            child: Text(
                              '我在\nWoWoW许愿啦\n向你许了一个愿望！',
                              style: TextStyle(
                                color: foregroundColor,
                                fontSize: 15.20,
                                fontWeight: FontWeight.w600,
                                height: 0,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 124,
                          top: 441.81,
                          child: Text(
                            'WoWoW许愿啦',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: foregroundColor,
                              fontSize: 11.40,

                              fontWeight: FontWeight.w600,
                              height: 0,
                            ),
                          ),
                        ),
                        Positioned(
                          left: 200.19,
                          top: 65.19,
                          child: Container(
                            width: 55.06,
                            height: 55.06,
                            child: SvgPicture.asset('assets/images/jiantou.svg',color: foregroundColor,),
                          ),
                        ),
                        Positioned(
                            right: 0,
                            top: 0,
                            child:Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SvgPicture.asset('assets/images/qr_code.svg',color: foregroundColor,),
                            )
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: AppStyle.postItemBoxDecoration,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                          onPressed: () async {
                            await SharePosterUtils.savePosterImage(repaintWidgetKey);
                          },
                          icon: const Icon(
                            Icons.download_for_offline,
                            color:AppColors.secondary,
                            size: 65,
                          )),
                    ],
                  ),
                ),
              ),
              Spacer()
            ],
          ),
        ),
      ),
    );
  }
}