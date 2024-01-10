import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wowowwish/components/widgets/app_tool_bar.dart';
import 'package:wowowwish/components/widgets/date_picker.dart';
import 'package:wowowwish/components/widgets/portrait.dart';
import 'package:wowowwish/components/widgets/time_picker.dart';
import 'package:wowowwish/routes/app_routes.dart';
import 'package:wowowwish/styles/app_colors.dart';
import 'package:wowowwish/utils/app_utils.dart';
import '../../../components/widgets/page_opt_user.dart';
import '../../../config/app_strings.dart';
import '../../../constants.dart';
import '../../../request/requests.dart';
import 'logic.dart';

class UserPage extends StatelessWidget {
  UserPage({Key? key}) : super(key: key);
  final logic = Get.put(UserLogic());

  @override
  Widget build(BuildContext context) {
    logic.onInit();
    return Scaffold(
      appBar: const ToolBar(title: AppStrings.mine),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 0),
        child: ListView(
          children: [
            const SizedBox(height: 10,),
            Container(
            height: 86,
            decoration: const BoxDecoration(
              boxShadow: [
            BoxShadow(
              color: AppColors.shadowColor,
              blurRadius: 10,
              offset: Offset(0, 2),
              spreadRadius: 0,
            )
              ],
              color: AppColors.borderSideColor,
              borderRadius: BorderRadius.all(
            Radius.circular(24),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Obx(() {
                return Portrait(
                  size: 25,
                  userUid: logic.account.value.userUid,
                  imgUrl: logic.pic.value == ''
                      ? null
                      : logic.pic.value,
                  onTap: () {
                    Get.toNamed(Routes.PORTRAIT);
                  },
                );
              }),
              const SizedBox(
                width: 25,
              ),
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(() {
                      return Text(
                        logic.account.value.name,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,

                          fontWeight: FontWeight.w600,
                        ),
                      );
                    }),
                    const Text(
                      AppStrings.realMe,
                      style: TextStyle(
                        color: AppColors.userMyCardRealMe,
                        fontSize: 12,

                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              // const Icon(
              //   Icons.qr_code_2,
              //   size: 25,
              //   color: Colors.black,
              // )
            ],
              ),
            ),
            ),
            const SizedBox(
              height: 30,
            ),
            Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
            '功能',
            style: TextStyle(
              color:AppColors.userOpeClass,
              fontSize: 13,

              fontWeight: FontWeight.w400,
            ),
              ),
              for (var name in logic.nameList_1)
            PageOpt(
              optName: name,
              onTap: logic.pageListUser()[name],
            ),
              const Text(
            '账户',
            style: TextStyle(
              color: AppColors.userOpeClass,
              fontSize: 13,

              fontWeight: FontWeight.w400,
            ),
              ),
              for (var name in logic.nameList_2)
            PageOpt(
              optName: name,
              onTap: logic.pageListUser()[name],
            ),
              const Text(
            '其他',
            style: TextStyle(
              color: AppColors.userOpeClass,
              fontSize: 13,

              fontWeight: FontWeight.w400,
            ),
              ),
              for (var name in logic.nameList_3)
            PageOpt(
              optName: name,
              onTap: logic.pageListUser()[name],
            ),
              const SizedBox(
            height: 15,
              ),
              SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.appBackground,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                        width: 0.48, color: AppColors.borderSideColor),
                    borderRadius: BorderRadius.circular(9),
                  ),
                ),
                onPressed: () {
                  appShowDialog(context, AppStrings.logout,'您确定要退出登录吗？', AppStrings.cancel, AppStrings.exit, () async{ var response=await AppRequest().logOut();
                  if(response['code']=='000001'){
                    boxAccount.erase();
                    boxFriend.erase();
                    boxReminder.erase();
                    box.erase();
                    // boxFlag.erase();
                    Get.offAllNamed(Routes.LOGIN);
                  } });

                },
                child: const Text(
                  AppStrings.logout,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.textOnUserAndWish,
                    fontSize: 14,

                    fontWeight: FontWeight.w600,
                  ),
                )),
              ),
              const SizedBox(height: 35,)

            ],
            ),
          ],
        ),
      ),
    );
  }
}
