import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wowowwish/components/widgets/app_tool_bar.dart';
import 'package:wowowwish/components/widgets/them_card.dart';
import '../../../config/app_strings.dart';
import 'logic.dart';

class ThemPage extends StatelessWidget {
  ThemPage({Key? key}) : super(key: key);
  final logic = Get.put(ThemLogic());

  @override
  Widget build(BuildContext context) {
    logic.onInit();

    return Scaffold(
      appBar: const ToolBar(title: AppStrings.taMen),
      body: Padding(
          padding: const EdgeInsets.all(13.0),
          child: ListView(
            children: [

              ThemCard(
                myThem: logic.friendList[0],
                index: 0,
              ),

              SizedBox(
                height: 20,
              ),
              ThemCard(
                myThem: logic.friendList[1],
                index: 1,
              ),

              const SizedBox(
                height: 20,
              ),
              ThemCard(
                myThem: logic.friendList[2],
                index: 2,
              ),
            ],
          ),),
    );
  }
}
