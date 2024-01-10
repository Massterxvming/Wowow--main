import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wowowwish/components/widgets/app_tool_bar.dart';
import 'package:wowowwish/config/app_strings.dart';
import 'package:wowowwish/constants.dart';
import 'package:wowowwish/request/app_request.dart';
import 'package:wowowwish/routes/app_routes.dart';
import 'package:wowowwish/utils/app_utils.dart';

import '../../../../../config/app_toast.dart';
import '../../../../../styles/app_colors.dart';
import 'logic.dart';

class AccountDeletePage extends StatelessWidget {
  AccountDeletePage({Key? key}) : super(key: key);
  final bodyStyle=const TextStyle(color: Colors.black,
    fontSize: 16,

    fontWeight: FontWeight.w500,);
  final logic = Get.find<AccountDeleteLogic>();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: const ToolBar(title: AppStrings.accountDelete),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '注意',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,

                fontWeight: FontWeight.w600,
              ),
            ),
             SizedBox(height: 30,),
             Row(
              children: [
                Expanded(
                    child: Text(
                  '此操作将注销您的账号，您帐号中的所有信息将被清除，包括但不限于：',
                  style: bodyStyle
                ),)
              ],
            ),
             SizedBox(height: 25,),
             Text('-添加的好友',
              style: bodyStyle),
            Text('-愿望相关信息',
              style:  bodyStyle),
            Text('-想要相关信息',
              style:bodyStyle),
            Text('-您和好友的互动数据',
              style:  bodyStyle),
            SizedBox(height: 25,),
            Row(
              children: [
                Expanded(
                  child: Text(
                    '我们将在服务器中抹除您所有的相关信息。此操作不可逆，请您谨慎选择。',
                    style: bodyStyle
                  ),)
              ],
            ),
            Spacer(),
            SizedBox(
              height: 45,
              width: double.infinity,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xffCC4646),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 0.48, color: AppColors.borderSideColor),
                      borderRadius: BorderRadius.circular(9),                  ),
                  ),

                  onPressed: (){
                    appShowDialog(context, AppStrings.accountDelete, '您确定要注销账号吗？', AppStrings.cancel, '注销', () async {
                      logic.showLoading();
                      var dio=AppRequestType().getDio();
                      var response=await dio.delete('/users?user_uid=${boxAccount.read('user_uid')}');
                      if(response.data['code']=='000001'){
                        appShowToast('注销成功');
                      }
                      boxAccount.erase();
                      boxFriend.erase();
                      logic.hideLoading();
                      Get.offAllNamed(Routes.LOGIN);
                    });
              }, child: const Text('确认',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,

                    fontWeight: FontWeight.w400,
                    height: 0.09,
                    letterSpacing: -0.43,
                  ),),),
            ),
            // Spacer()
          ],
        ),
      ),
    );
  }
}
