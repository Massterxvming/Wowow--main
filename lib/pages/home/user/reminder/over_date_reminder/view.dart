import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wowowwish/constants.dart';

import '../../../../../components/widgets/REmptyView.dart';
import '../../../../../components/widgets/app_tool_bar.dart';
import '../../../../../model/reminder.dart';
import '../../../../../request/requests.dart';
import '../view.dart';
import 'logic.dart';

class OverDateReminderPage extends StatelessWidget {
  OverDateReminderPage({Key? key}) : super(key: key);

  final logic = Get.find<OverDateReminderLogic>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ToolBar(
        title: '已过期',
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          FutureBuilder(
              future: getReminder(boxAccount.read('user_uid')),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text(
                        '加载失败,请重试',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,

                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    );
                  } else {
                    return logic.reminderListOverDate.isEmpty?const Center(child: REmptyView(dataText: '您还没有已过期的纪念日哦')):ReminderCardList(
                        reminderList: logic.reminderListOverDate);
                  }
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              })
        ]),
      ),
    );
  }

  getReminder(int userUid) async {
    var response = await AppRequest().getReminder(userUid);
    logic.reminderListOverDate = [];
    for (var json in response['data']) {
      if (Reminder.fromJson(json).gap < 0) {
        logic.reminderListOverDate.add(Reminder.fromJson(json));
      }
    }
    logic.reminderListOverDate.sort(
      (a, b) => a.date.compareTo(b.date),
    );
  }
}
