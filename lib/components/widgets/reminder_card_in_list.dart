import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:wowowwish/config/app_toast.dart';
import 'package:wowowwish/model/reminder.dart';
import 'package:wowowwish/request/requests.dart';
import 'package:wowowwish/styles/app_colors.dart';

class ReminderCardInList extends StatefulWidget {
  const ReminderCardInList({super.key, required this.reminder});
  final Reminder reminder;

  @override
  State<ReminderCardInList> createState() => _ReminderCardInListState();
}

class _ReminderCardInListState extends State<ReminderCardInList> {
  bool flag = true;

  @override
  Widget build(BuildContext context) {
    return flag
        ? Padding(
            padding: const EdgeInsets.all(7.0),
            child: GestureDetector(
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Container(
                        width: double.infinity,
                        height: 400,
                        child: Column(
                          children: [
                            Spacer(),
                            Padding(
                              padding: const EdgeInsets.all(30.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      widget.reminder.description,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        height: 0,
                                      ),
                                      maxLines: 3,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              '${widget.reminder.date.year}/${widget.reminder.date.month < 10 ? '0${widget.reminder.date.month}' : '${widget.reminder.date.month}'}/${widget.reminder.date.day < 10 ? '0${widget.reminder.date.day}' : '${widget.reminder.date.day}'}',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Color(0xFF797B74),
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                height: 0,
                              ),
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                height: 50,
                                width: 300,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.appBackground,
                                      shape: RoundedRectangleBorder(
                                        side: const BorderSide(
                                            width: 0.50,
                                            color: AppColors.borderSideColor),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                    ),
                                    onPressed: () async {
                                      var response = await AppRequest()
                                          .delReminder(
                                              widget.reminder.reminderId);
                                      if (response['code'] == '000001') {
                                        appShowToast('删除成功');
                                        setState(() {
                                          flag = false;
                                        });
                                        Get.back();
                                      }
                                    },
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          '删除',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Color(0xFFE34949),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            height: 0,
                                          ),
                                        ),
                                        Spacer(),
                                        Icon(
                                          Icons.delete_forever_outlined,
                                          color: Color(0xFFE34949),
                                        )
                                      ],
                                    )),
                              ),
                            ),
                            Spacer()
                          ],
                        ),
                      );
                    });
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.only(
                  top: 17,
                  left: 22,
                  right: 5,
                  bottom: 17,
                ),
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  color: AppColors.appBackground,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(width: 1, color: AppColors.borderSideColor),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  shadows:  [//jh
                    BoxShadow(
                      color: AppColors.shadowColor,
                      blurRadius: 10,
                      offset: Offset(0, 2),
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 12,
                      child: Text(
                        widget.reminder.description,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          height: 0,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const Spacer(),
                    Expanded(
                      flex: 4,
                      child: Text(
                        '${widget.reminder.date.year}/${widget.reminder.date.month < 10 ? '0${widget.reminder.date.month}' : '${widget.reminder.date.month}'}/${widget.reminder.date.day < 10 ? '0${widget.reminder.date.day}' : '${widget.reminder.date.day}'}',
                        style: const TextStyle(
                          color: Color(0xFF797B74),
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          height: 0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        : Container();
  }
}
