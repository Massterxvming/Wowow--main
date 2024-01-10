import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wowowwish/components/widgets/app_text_field.dart';
import 'package:wowowwish/components/widgets/app_tool_bar.dart';
import 'package:wowowwish/config/app_strings.dart';
import 'package:wowowwish/pages/home/user/logic.dart';
import '../../../../../styles/app_colors.dart';
import 'logic.dart';

class EditUsernamePage extends StatelessWidget {
  EditUsernamePage({Key? key}) : super(key: key);
  final userLogic = Get.find<UserLogic>();
  final logic = Get.put(EditUsernameLogic());

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: const ToolBar(title: AppStrings.editUsername),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const SizedBox(height: 8,),
            AppTextField(hint: logic.username,
                labelText: '请输入昵称',
                onChanged: (value) {
                  logic.username=value;
                }
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(onPressed: () async {
                FocusScope.of(context).requestFocus(FocusNode());
                logic.showLoading();
                await logic.onConfirm();
                logic.hideLoading();
              },
                style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.blackElevated,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(
                      width: 0.48, color: AppColors.borderSideColor),
                  borderRadius: BorderRadius.circular(9),
                ),
              ),
               child:  const Text(
                   '确认',
                   textAlign: TextAlign.center,
                   style: TextStyle(
                     color: Colors.white,
                     fontSize: 16,
                     fontWeight: FontWeight.w400,
                     height: 0.09,
                     letterSpacing: -0.43,
                   ),),
            ),),
            SizedBox(height: 15,)
          ],//
        ),
      ),

    );
  }
}
