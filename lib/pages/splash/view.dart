import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wowowwish/constants.dart';
import 'package:wowowwish/routes/app_routes.dart';
import 'package:wowowwish/styles/app_colors.dart';

import '../../config/app_strings.dart';
import 'logic.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final logic = Get.put(SplashLogic());
  void _toPrivacy() {
    Get.toNamed(Routes.PRIVACY);
  } void _toTerms() {
    Get.toNamed(Routes.TERMS);
  }

  void _showCustomDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      barrierColor: AppColors.appBackground,
      // false = user must tap button, true = tap outside dialog
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: AppColors.dialog,
          title: const Text(
            '隐私政策',
            style: TextStyle(
              color: AppColors.font,
              fontSize: 24,

              fontWeight: FontWeight.w400,
              height: 1.33,
            ),
          ),
          content: SizedBox(
            width: 300,
            child: Text.rich(
              TextSpan(
                children: [
                  const TextSpan(
                    text: '欢迎使用WoWoW许愿啦！请您充分阅读并理解',
                    style: TextStyle(
                      color: Color(0xFF49454F),
                      fontSize: 14,

                      fontWeight: FontWeight.w400,
                      height: 1.43,
                      letterSpacing: 0.25,
                    ),
                  ),
                  TextSpan(
                    recognizer: TapGestureRecognizer()..onTap = _toPrivacy,
                    text: '《隐私政策》',
                    style: const TextStyle(
                      color: AppColors.secondary,
                      fontSize: 14,

                      fontWeight: FontWeight.w400,
                      height: 1.43,
                      letterSpacing: 0.25,
                    ),
                  ),const TextSpan(
                    text: '、',
                    style: TextStyle(
                      color: AppColors.secondary,
                      fontSize: 14,

                      fontWeight: FontWeight.w400,
                      height: 1.43,
                      letterSpacing: 0.25,
                    ),
                  ),TextSpan(
                    recognizer: TapGestureRecognizer()..onTap = _toTerms,
                    text: '《条款与条件》',
                    style: const TextStyle(
                      color: AppColors.secondary,
                      fontSize: 14,

                      fontWeight: FontWeight.w400,
                      height: 1.43,
                      letterSpacing: 0.25,
                    ),
                  ),
                  const TextSpan(
                    text:
                        '。为了更好的为您服务，我们将在您的使用过程中申请本地储存，相机等权限。点击同意则代表您已阅读并同意此条款。',
                    style: TextStyle(
                      color: Color(0xFF49454F),
                      fontSize: 14,

                      fontWeight: FontWeight.w400,
                      height: 1.43,
                      letterSpacing: 0.25,
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  child: const Text(
                    AppStrings.refuse,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.secondary,
                      fontSize: 17,

                      fontWeight: FontWeight.w400,
                      height: 1.50,
                    ),
                  ),
                  onPressed: () {
                    exit(0);
                  },
                ),
                TextButton(
                  child: const Text(
                    AppStrings.agree,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.secondary,
                      fontSize: 17,

                      fontWeight: FontWeight.w400,
                      height: 1.50,
                    ),
                  ),
                  onPressed: () {
                    Get.offAllNamed(Routes.GUIDE);
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }
 late Timer timerDisplay;
  int gap = 3;
  @override
  void initState() {
      if (boxFlag.read('isFirstTime') == true) {
        timerDisplay = Timer(const Duration(seconds: 1), () {
          _showCustomDialog(context);
        });
      }else{
        _startTimer();
      }
    super.initState();
  }

  void _startTimer(){
    const oneSec = const Duration(seconds: 1);
    timerDisplay = Timer.periodic(oneSec, (timer) {
      setState(() {
        if(gap==1){
          timer.cancel();
          Get.offNamed(Routes.JUDGE);
        }else{
          setState(() {
            gap--;
          });
        }
      });
    });
  }
  @override
  void dispose()  {
    if(timerDisplay.isActive){
      timerDisplay.cancel();
    }
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(
        children: [
          boxFlag.read('isFirstTime')?Container():Positioned(
              right: 12,
              top: MediaQuery.of(context).padding.top+10,
              child: SizedBox(
                height: 25,
                width: 65,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.only(left: 7, right: 4),
                      backgroundColor: const Color(0xCC373737),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    onPressed: () {
                  timerDisplay.cancel();
                  Get.offNamed(Routes.JUDGE);
                }, child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text('$gap',textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,

                        fontWeight: FontWeight.w400,
                        height: 0.11,
                      ),),
                    Container(
                      width: 1,
                      height: 25,
                      decoration: const BoxDecoration(color: AppColors.appBackground),
                    ),
                    const Text('跳过',textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,

                        fontWeight: FontWeight.w400,
                        height: 0.11,
                      ),),
                  ],
                )),
              )),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/3.png',
                  height: 100,
                  width: 100,
                ),
                const SizedBox(
                  height: 35,
                ),
                const Text(
                  'WoWoW许愿啦',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,

                    fontWeight: FontWeight.w600,
                    height: 1.33,
                    letterSpacing: -0.42,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
