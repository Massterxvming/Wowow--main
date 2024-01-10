import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wowowwish/components/widgets/app_tool_bar.dart';
import 'package:wowowwish/config/app_strings.dart';
import 'package:wowowwish/styles/app_style.dart';

import 'logic.dart';

class SystemSettingPage extends StatelessWidget {
  SystemSettingPage({Key? key}) : super(key: key);

  final logic = Get.put(SystemSettingLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ToolBar(title: AppStrings.setting),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 50,
              decoration: AppStyle.shapeDecoration,
              child: const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    '版本：v1.3.7',
                    style: TextStyle(
                      color: Color(0xFF242424),
                      fontSize: 16,

                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
