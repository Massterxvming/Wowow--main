import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wowowwish/constants.dart';
import 'package:wowowwish/pages/home/logic.dart';
import 'package:wowowwish/pages/home/view.dart';
import 'package:wowowwish/wish_counter_logic.dart';

import 'app.dart';

//final Userbas=Userbas 创建一个类的对象用final，flutter的规范

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();
void main() async{
  await GetStorage.init('MyAccount');
  await GetStorage.init('MyFriend');
  await GetStorage.init('Flag');
  await GetStorage.init('Reminder');
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  await getApplicationDocumentsDirectory();

  const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('mipmap/ic_launcher');
  const DarwinInitializationSettings initializationSettingsIOS= DarwinInitializationSettings(
    onDidReceiveLocalNotification: onDidReceiveLocalNotification
  );
  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings,//唤醒本地推送插件
  onDidReceiveNotificationResponse: onDidReceiveNotificationResponse
  );
  runApp(WoWoWWishApp());
}//main


void onDidReceiveLocalNotification(int id,String? title,String? body,String? payload){
}
void onDidReceiveNotificationResponse(NotificationResponse notificationResponse)async{
  clearWishCount();
  await Get.offAll(const HomePage(menus: Menus.wishList,));
}

