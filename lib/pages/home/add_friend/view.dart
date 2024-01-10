import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:wowowwish/components/widgets/app_text_field.dart';
import 'package:wowowwish/components/widgets/app_tool_bar.dart';
import 'package:wowowwish/config/app_strings.dart';
import 'package:wowowwish/pages/home/them/logic.dart';
import 'package:wowowwish/pages/home/wish/logic.dart';
import 'package:wowowwish/styles/app_text.dart';

import '../../../styles/app_colors.dart';
import 'logic.dart';

class AddFriendPage extends StatelessWidget {
  AddFriendPage({Key? key}) : super(key: key);

  final logic = Get.find<AddFriendLogic>();
  final wishLogic = Get.find<WishLogic>();
  final themLogic = Get.find<ThemLogic>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Obx(() =>
              Text('添加${logic.relationInTitle.value}', style: const TextStyle(
                color: AppColors.font2,
                fontSize: 18,
                fontWeight: FontWeight.w600,
                height: 0.07,
                letterSpacing: -0.43,
              ),)),
          backgroundColor: AppColors.appBackground,
          scrolledUnderElevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 8,),
              SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: AppTextField(
                    maxLength: 11,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                    ],
                    labelText: '请输入手机号',
                    hint: '手机号',
                    onChanged: (value) {
                      logic.getAddPhone(value);
                    },
                  )),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.black,
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                          width: 0.48, color: AppColors.borderSideColor),
                      borderRadius: BorderRadius.circular(9),
                    ),
                  ),
                  onPressed: () async {
                    logic.showLoading();
                    await logic.onConfirm();
                    logic.hideLoading();
                  },
                  child: const Text(
                    '添加',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      height: 1.38,
                      letterSpacing: -0.43,
                    ),
                  ),

                ),
              ),
              SizedBox(height: 20,)
            ],
          ),
        ));
  }
}
