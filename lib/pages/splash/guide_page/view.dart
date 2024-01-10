import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import '../../../config/app_strings.dart';
import '../../../constants.dart';
import '../../../main.dart';
import '../../../routes/app_routes.dart';
import 'logic.dart';

class GuidePagePage extends StatelessWidget {
  GuidePagePage({Key? key}) : super(key: key);

  final logic = Get.find<GuidePageLogic>();

  @override
  Widget build(BuildContext context) {
    return  const Scaffold(
      body: PageViewWidget(),
    );
  }
}



class PageViewWidget extends StatefulWidget {
  const PageViewWidget({super.key});
  static bool flag=true;
  @override
  State<PageViewWidget> createState() => _PageViewWidgetState();
}
class _PageViewWidgetState extends State<PageViewWidget> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentIndex=0;
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        PageView.builder(
            controller: _pageController,
            itemCount: 3,
            onPageChanged: (index){
              setState(() {
                _currentIndex=index;
              });
            },
            itemBuilder: (BuildContext context, int index) {
              return
                index==0
                    ?Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 205,
                      height: 206,
                      child: Stack(
                        children: [
                          Positioned(//紫圆
                            left: 3,
                            top: 55,
                            child: Container(
                              width: 110,
                              height: 110,
                              decoration: const ShapeDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment(-0.08, 1.00),
                                  end: Alignment(0.08, -1),
                                  colors: [Color(0x003442C2), Color(0x993442C2)],
                                ),
                                shape: OvalBorder(),
                              ),
                            ),
                          ),
                          Positioned(//绿圆
                            left: 58,
                            top: 0,
                            child: Container(
                              width: 110,
                              height: 110,
                              decoration: const ShapeDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment(0.71, 0.70),
                                  end: Alignment(-0.71, -0.7),
                                  colors: [Color(0xFF31C791), Color(0x992CF6AD), Color(0x592CF7AE)],
                                ),
                                shape: OvalBorder(),
                              ),
                            ),
                          ),
                          Positioned(//粉圆
                            left: 95,
                            top: 84,
                            child: Container(
                              width: 110,
                              height: 110,
                              decoration: const ShapeDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment(0.84, -0.54),
                                  end: Alignment(-0.84, 0.54),
                                  colors: [Color(0x99FF71A4), Color(0x1CFF6767)],
                                ),
                                shape: OvalBorder(),
                              ),
                            ),
                          ),
                          Positioned(//左上点
                            left: 0,
                            top: 11,
                            child: Container(
                              width: 39,
                              height: 39,
                              decoration: ShapeDecoration(
                                color: Color(0xFFDEE3C9),
                                shape: OvalBorder(),
                              ),
                            ),
                          ),
                          Positioned(//下点
                            left: 71,
                            top: 169,
                            child: Container(
                              width: 19,
                              height: 19,
                              decoration: ShapeDecoration(
                                color: Color(0xFFDEE3CA),
                                shape: OvalBorder(),
                              ),
                            ),
                          ),
                          Positioned(//右上点
                            left: 176,
                            top: 60,
                            child: Container(
                              width: 20,
                              height: 20,
                              decoration: ShapeDecoration(
                                color: Color(0xFFDEE3CA),
                                shape: OvalBorder(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 80,),
                    const Text(
                      '寻找生命中的三个WO',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,

                        fontWeight: FontWeight.w600,
                        height: 1.10,
                        letterSpacing: -0.43,
                      ),
                    ),
                    const SizedBox(height: 6,),
                    const Text(
                      '承载生命，不可或缺',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF929684),
                        fontSize: 16,

                        fontWeight: FontWeight.w600,
                        height: 1.38,
                        letterSpacing: -0.43,
                      ),
                    )
                  ],
                )
                    : index == 1
                    ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 221,
                      height: 206,
                      clipBehavior: Clip.antiAlias,
                      decoration: ShapeDecoration(
                        gradient: LinearGradient(
                          begin: Alignment(0.00, -1.00),
                          end: Alignment(0, 1),
                          colors: [Color(0xCC68CAB3), Color(0x2200FFC1)],
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(31),
                        ),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            left: 18,
                            top: 21,
                            child: Container(
                              width: 184,
                              height: 35,
                              padding: const EdgeInsets.only(top: 5, left: 123, right: 5, bottom: 5),
                              clipBehavior: Clip.antiAlias,
                              decoration: ShapeDecoration(
                                color: Colors.white.withOpacity(0.11999999731779099),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                shadows: [
                                  BoxShadow(
                                    color: Color(0x05000000),
                                    blurRadius: 10,
                                    offset: Offset(0, 2),
                                    spreadRadius: 0,
                                  )
                                ],
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 56,
                                    height: 25,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: ShapeDecoration(
                                      color: Colors.white.withOpacity(0.11999999731779099),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            left: 18,
                            top: 86,
                            child: Container(
                              width: 184,
                              height: 35,
                              padding: const EdgeInsets.only(top: 5, left: 123, right: 5, bottom: 5),
                              clipBehavior: Clip.antiAlias,
                              decoration: ShapeDecoration(
                                color: Colors.white.withOpacity(0.11999999731779099),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                shadows: [
                                  BoxShadow(
                                    color: Color(0x05000000),
                                    blurRadius: 10,
                                    offset: Offset(0, 2),
                                    spreadRadius: 0,
                                  )
                                ],
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 56,
                                    height: 25,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: ShapeDecoration(
                                      color: Colors.white.withOpacity(0.11999999731779099),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            left: 18,
                            top: 151,
                            child: Container(
                              width: 184,
                              height: 35,
                              padding: const EdgeInsets.only(top: 5, left: 123, right: 5, bottom: 5),
                              clipBehavior: Clip.antiAlias,
                              decoration: ShapeDecoration(
                                color: Colors.white.withOpacity(0.11999999731779099),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                shadows: [
                                  BoxShadow(
                                    color: Color(0x05000000),
                                    blurRadius: 10,
                                    offset: Offset(0, 2),
                                    spreadRadius: 0,
                                  )
                                ],
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 56,
                                    height: 25,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: ShapeDecoration(
                                      color: Colors.white.withOpacity(0.11999999731779099),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            left: 15,
                            top: 32.40,
                            child: Transform(
                              transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(-0.47),
                              child: Container(
                                width: 29.79,
                                height: 29.79,
                                decoration: ShapeDecoration(
                                  color: Color(0xFFF8E111),
                                  shape: StarBorder(
                                    points: 5,
                                    innerRadiusRatio: 0.50,
                                    pointRounding: 0.5,
                                    valleyRounding: 0,
                                    rotation: 0,
                                    squash: 0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 80,),
                    const Text(
                      '相互许愿，管理愿望',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,

                        fontWeight: FontWeight.w600,
                        height: 1.10,
                        letterSpacing: -0.43,
                      ),
                    ),
                    const SizedBox(height: 6,),
                    const Text(
                      '强化关系纽带',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF929684),
                        fontSize: 16,

                        fontWeight: FontWeight.w600,
                        height: 1.38,
                        letterSpacing: -0.43,
                      ),
                    )
                  ],
                )
                    : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 190.98,
                      height: 206,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 40.87,
                            top: 6,
                            child: Container(//圆
                              width: 121.70,
                              height: 121.70,
                              decoration: const ShapeDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment(-0.66, -0.75),
                                  end: Alignment(0.66, 0.75),
                                  colors: [Color(0xCCF5E020), Color(0x33F5E020)],
                                ),
                                shape: OvalBorder(),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 85.98,
                            top: 101,
                            child: Container(//正方形
                              width: 105,
                              height: 105,
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment(-0.78, -0.62),
                                  end: Alignment(0.78, 0.62),
                                  colors: [Color(0xAA298CE7), Color(0x11298CE7)],
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                              top: 0,
                              bottom:0,
                              left: 0,
                              child: Container(//三角
                                height: 205,
                                width: 250,
                                transform: Matrix4.rotationZ(pi/3),
                                decoration: BoxDecoration(
                                    gradient:LinearGradient(colors: [Color(0xAAFF8800),Color(0x00FF8800)],
                                        begin: Alignment(-0.5, -0.5),
                                        end: Alignment(0.5,0.5)
                                    )
                                ),
                              ))
                        ],
                      ),
                    ),
                    const SizedBox(height: 80,),
                    const Text(
                      '更多功能等你发现',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,

                        fontWeight: FontWeight.w600,
                        height: 1.10,
                        letterSpacing: -0.43,
                      ),
                    ),
                    const SizedBox(height: 6,),
                    const Text(
                      '尽情探索吧',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF929684),
                        fontSize: 16,

                        fontWeight: FontWeight.w600,
                        height: 1.38,
                        letterSpacing: -0.43,
                      ),
                    )
                  ],
                );
            }),
        _currentIndex==2?
        Positioned(
            left: 70,
            right: 70,
            bottom: MediaQuery.of(context).padding.bottom + 40,
            child: SizedBox(
              height: 40,width: 150,
              child: ElevatedButton(onPressed: (){
                boxFlag.write('isFirstTime', false);
                boxFlag.write('isNotificationGrand', true);
                Get.offAllNamed(Routes.LOGIN);
                flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
                    AndroidFlutterLocalNotificationsPlugin>()?.requestPermission();
              },style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF2E2E2E)
              ), child: const Text('我知道了',textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  height: 1.38,
                  letterSpacing: -0.43,
                ),)),
            )):
        Positioned(
            left: 0,
            right: 0,
            bottom: MediaQuery.of(context).padding.bottom + 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 10,
                  height: 10,
                  clipBehavior: Clip.antiAlias,
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentIndex==0
                          ?Color(0xFF1F1F1F)
                          :Color(0xFFB4B7A7)
                  ),
                ),
                Container(
                  width: 10,
                  height: 10,
                  clipBehavior: Clip.antiAlias,
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentIndex==1
                          ?Color(0xFF1F1F1F)
                          :Color(0xFFB4B7A7)
                  ),
                ),
                Container(
                  width: 10,
                  height: 10,
                  clipBehavior: Clip.antiAlias,
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentIndex==2
                          ?Color(0xFF1F1F1F)
                          :Color(0xFFB4B7A7)
                  ),
                ),
              ],
            )
        ),
      ],
    );
  }
}


