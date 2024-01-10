import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:wowowwish/components/widgets/app_tool_bar.dart';
import 'package:wowowwish/routes/app_routes.dart';

import '../../../components/widgets/app_text_field.dart';
import '../../../config/app_strings.dart';
import '../../../config/app_toast.dart';
import '../../../constants.dart';
import '../../../request/requests.dart';
import '../../../styles/app_colors.dart';
import 'logic.dart';

class ForgetPage extends StatefulWidget {
  ForgetPage({Key? key}) : super(key: key);

  @override
  State<ForgetPage> createState() => _ForgetPageState();
}

class _ForgetPageState extends State<ForgetPage> {
  final logic = Get.find<ForgetLogic>();
  bool _isGetCodeActive = true;
  int seconds = 15;
  bool _isIdCodeRight = false;
  Timer? _getCodeTimer;
  String text = '发送验证码';
  void _startTimerTask() {
    const onSecond = Duration(seconds: 1);
    _getCodeTimer = Timer.periodic(onSecond, (timer) {
      setState(() {
        if (seconds > 0) {
          seconds--;
          text = '$seconds秒';
        } else {
          _isGetCodeActive = true;
          text = '发送验证码';
          _getCodeTimer!.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    if (_getCodeTimer != null) {
      _getCodeTimer!.cancel();
    }
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ToolBar(title: '忘记密码'),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            AppTextField(
              maxLength: 11,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
              ],
              hint: AppStrings.phoneNumber,
              labelText: '请输入手机号',
              onChanged: (value) {
                logic.phoneNumber = value;
              },
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 6,
                    child: AppTextField(
                  hint: '验证码',
                  maxLength: 6,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                  ],
                  labelText: '请输入验证码',
                  onChanged: (val) {
                    logic.idCode = val;
                    if (logic.idCode.length == 6) {
                      setState(() {
                        _isIdCodeRight = true;
                      });
                    } else {
                      setState(() {
                        _isIdCodeRight = false;
                      });
                    }
                  },
                )),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  flex: 4,
                  child: SizedBox(
                    height: 60,
                    width: 150,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _isGetCodeActive
                            ? const Color(0xFF2D2D2D)
                            : Colors.grey[400],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () async {
                        if (_isGetCodeActive) {
                          if (isChinesePhoneNumber(logic.phoneNumber)) {
                            seconds = 60;
                            _startTimerTask();
                            text = '$seconds秒';
                            setState(() {
                              _isGetCodeActive = false;
                            });
                            await logic.getVerifyCode();

                          } else {
                            appShowToast('请输入正确的手机号码');
                          }
                        } else {
                          appShowToast('请$seconds秒后重试');
                        }
                      },
                      child: Text(
                        text,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          height: 1.47,
                          letterSpacing: -0.43,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            const Spacer(),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF2D2D2D),
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                          width: 0.48, color: AppColors.borderSideColor),
                      borderRadius: BorderRadius.circular(9),
                    ),
                  ),
                  onPressed: () async {
                    FocusScope.of(context).requestFocus(FocusNode());
                    if (logic.definePhoneNumber == logic.phoneNumber &&
                        logic.idCode == logic.defineCode) {
                      var responseLogin = await AppRequest().getTokenWithMethod('SMS', logic.phoneNumber, logic.idCode);
                      if(responseLogin['code']=='000001'){
                        int responseGetUserUid =
                        await AppRequest().getAccountUid(logic.phoneNumber,responseLogin['data']['token']);
                        Get.toNamed(Routes.RESETPASSWORD,arguments: [responseLogin['data']['token'],responseGetUserUid]);
                      }else{
                        appShowToast('该手机号尚未注册');
                      }
                    } else {
                      appShowToast('手机号或验证码无效');
                    }

                  },
                  child: const Text(
                    '下一步',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      height: 1.38,
                      letterSpacing: -0.43,
                    ),
                  )),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
