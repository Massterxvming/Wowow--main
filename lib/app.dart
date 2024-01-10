import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_isolate/flutter_isolate.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:wowowwish/constants.dart';
import 'package:wowowwish/main.dart';
import 'package:wowowwish/request/requests.dart';

import 'package:wowowwish/routes/app_routes.dart';
import 'package:wowowwish/styles/app_colors.dart';
import 'package:wowowwish/wish_counter_logic.dart';

class WoWoWWishApp extends StatelessWidget {

  WoWoWWishApp({super.key});

  final WishCounterLogic wishCounterLogic=Get.put(WishCounterLogic());
  @override
  Widget build(BuildContext context){
    ever(wishCounterLogic.wishCount, (newValue) {
      if(boxFlag.hasData('isNotificationGrand')){
        if(wishCounterLogic.wishCount.value!=0){
          showNotification(wishCounterLogic.wishCount.value);
        }
      }
    });
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        systemNavigationBarColor: AppColors.appBackground));//系统背景颜色
    return GetMaterialApp(
      title: 'WoWoW许愿啦',
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.INITIAL,
      getPages: AppPages.pages,
      theme: ThemeData(
          colorScheme: AppColors.lightGreenScheme,
          useMaterial3: true,
          fontFamily: 'NotoSansSc'
      ),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: const [Locale('en', 'US')],
    );
  }//
  Future<void> showNotification(int count) async{
    const AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails('wowow_wish', 'WoWoW许愿啦',channelDescription: '接受愿望提醒',importance: Importance.high,priority: Priority.defaultPriority,ticker: '新愿望');
    const NotificationDetails notificationDetails=NotificationDetails(
        android: androidNotificationDetails
    );
    await flutterLocalNotificationsPlugin.show(1, '收愿箱提醒', '您收到了$count条新愿望，请及时查收哦。', notificationDetails);
  }

}

