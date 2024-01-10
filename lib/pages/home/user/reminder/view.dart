import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wowowwish/components/widgets/REmptyView.dart';
import 'package:wowowwish/components/widgets/app_tool_bar.dart';
import 'package:wowowwish/components/widgets/date_picker.dart';
import 'package:wowowwish/components/widgets/reminder_card_in_list.dart';
import 'package:wowowwish/config/app_strings.dart';
import 'package:wowowwish/config/app_toast.dart';
import 'package:wowowwish/constants.dart';
import 'package:wowowwish/model/reminder.dart';
import 'package:wowowwish/request/requests.dart';
import 'package:wowowwish/routes/app_routes.dart';
import 'package:wowowwish/styles/app_colors.dart';

import '../../../../styles/app_style.dart';
import 'logic.dart';

enum RemindType { myRemind, defaultRemind }

class ReminderPage extends StatefulWidget {
  const ReminderPage({Key? key}) : super(key: key);

  @override
  State<ReminderPage> createState() => _ReminderPageState();
}

class _ReminderPageState extends State<ReminderPage> {
  final logic = Get.find<ReminderLogic>();
  RemindType selectDisplay = RemindType.myRemind;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ToolBar(
        title: AppStrings.markDate,
        actions: [
          IconButton(
              onPressed: () {
                Get.toNamed(Routes.OVERDATEREMINDER);
              },
              icon: const Icon(Icons.update))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            FutureBuilder(
                future: getReminder(boxAccount.read('user_uid')),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return const Center(
                        child: REmptyView(dataText: '网络错误\n请检查网络连接'),
                      );
                    } else {
                      return logic.reminderList.isEmpty?const Center(child: REmptyView(dataText: '纪念日提醒列表为空\n请点击右下角按钮添加')):ReminderCardList(reminderList: logic.reminderList);
                    }
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                })
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var pickDate = await showAppDatePicker(context);
          if(pickDate==null){

          }else{
            showModalBottomSheet(
                context: context,
                builder: (context) {
                  return SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: AddReminderBottomSheet(
                        pickDate: pickDate,
                      ),
                    ),
                  );
                });
          }

        },
        backgroundColor: AppColors.appBackground,
        splashColor: AppColors.secondary,
        child: const Icon(Icons.add),
      ),
    );
  }

  getReminder(int userUid) async {
    var response = await AppRequest().getReminder(userUid);
    logic.reminderList = [];
    for (var json in response['data']) {
      if (Reminder.fromJson(json).gap >= 0) {
        logic.reminderList.add(Reminder.fromJson(json));
      }
    }
    logic.reminderList.sort(
      (a, b) => a.date.compareTo(b.date),
    );
  }
}

class ReminderCardList extends StatelessWidget {
  const ReminderCardList({super.key, required this.reminderList});
  final List<Reminder> reminderList;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: [
          for (var item in reminderList) ReminderCardInList(reminder: item)
        ],
      ),
    );
  }
}

class AddReminderBottomSheet extends StatefulWidget {
  const AddReminderBottomSheet({super.key, required this.pickDate});
  final DateTime pickDate;

  @override
  State<AddReminderBottomSheet> createState() => _AddReminderBottomSheetState();
}

class _AddReminderBottomSheetState extends State<AddReminderBottomSheet> {
  String content = '';

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
    return Container(
      width: double.infinity,
      decoration: const ShapeDecoration(
        color: AppColors.appBackground,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        shadows: [
          BoxShadow(
            color: AppColors.shadowColor,
            blurRadius: 10,
            offset: Offset(0, -2),
            spreadRadius: 0,
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 2, left: 12, right: 12, bottom: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextField(
              onChanged: (val) {
                content = val;
              },
              maxLength: 30,
              decoration: const InputDecoration(
                hintStyle: TextStyle(
                  color: AppColors.hintColor
                ),
                  border: InputBorder.none,
                  counterText: '',
                  hintText: '请输入内容(30字内)',),
            ),
            // SizedBox(
            //   height: 5,
            // ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 35,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(Icons.date_range_sharp),
                      SizedBox(width: 5,),
                      Text(
                        '${widget.pickDate.year}/${widget.pickDate.month < 10 ? '0${widget.pickDate.month}' : '${widget.pickDate.month}'}/${widget.pickDate.day < 10 ? '0${widget.pickDate.day}' : '${widget.pickDate.day}'}',
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                IconButton(
                    onPressed: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                    icon: const Icon(
                      Icons.keyboard_hide_outlined,
                      size: 25,
                    )),
                const SizedBox(
                  width: 5,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if(content!=''){
                      showLoading();
                      var response = await AppRequest().addReminder(
                          boxAccount.read('user_uid'),
                          widget.pickDate.toString(),
                          content);
                      if (response['code'] == '000001') {
                        appShowToast('添加成功');
                        print(response['data']);
                        Get.back();
                        Get.back();
                        Get.back();
                        hideLoading();
                        Get.toNamed(Routes.REMINDER);
                      } else{
                        appShowToast('未知错误，添加失败');
                        Get.back();
                      }
                    }else {
                      appShowToast('请输入内容');
                    }

                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.appBackground,
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                          width: 0.48, color: AppColors.borderSideColor),
                      borderRadius: BorderRadius.circular(9),
                    ),
                  ),
                  child: const Text(
                    '添加',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).padding.bottom,
            ),
          ],
        ),
      ),
    );
  }
}
