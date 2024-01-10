import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:wowowwish/components/widgets/app_tool_bar.dart';
import 'package:wowowwish/config/app_strings.dart';
import 'package:wowowwish/config/app_toast.dart';
import '../../../components/widgets/app_text_field.dart';
import '../../../components/widgets/password_text_field.dart';
import '../../../constants.dart';
import '../../../routes/app_routes.dart';
import '../../../styles/app_colors.dart';
import '../../../styles/app_text.dart';
import 'logic.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  List flag = [true, false];

  final logic = Get.find<SignUpLogic>();
  bool _isGetCodeActive = true;
  bool _switchPrivacy=false;
  bool _isPhoneNumberRight = false;
  bool _isIdCodeRight = false;
  int seconds = 10;
  String text = '发送验证码';
  Timer? _getCodeTimer;
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
    if(_getCodeTimer!=null){
      _getCodeTimer!.cancel();
    }
    // TODO: implement dispose
    super.dispose();
  }
  void _toPrivacy(){
    Get.toNamed(Routes.PRIVACY);
  }
  void _toTerms(){
    Get.toNamed(Routes.TERMS);
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: const ToolBar(title: '注册'),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 20,),
              AppTextField(
                maxLength: 11,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                ],
                hint: AppStrings.phoneNumber,
                labelText: '请输入手机号',
                onChanged: (value) {
                  logic.mobilePhone = value;
                  if(logic.mobilePhone.length==11){
                    setState(() {_isPhoneNumberRight=true;});
                  }else{
                    setState(() {
                      _isPhoneNumberRight=false;
                    });
                  }
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
                      if(logic.idCode.length==6){
                        setState(() {_isIdCodeRight=true;});
                      }else{
                        setState(() {_isIdCodeRight=false;});
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
                              ? AppColors.blackElevated
                              : Colors.grey[400],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () async {
                          if (_isGetCodeActive) {
                            if(isChinesePhoneNumber(logic.mobilePhone)){
                              seconds = 60;
                              _startTimerTask();
                              text = '$seconds秒';
                              setState(() {
                                _isGetCodeActive = false;
                              });
                              await logic.getVerifyCode();
                            }else{
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
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Expanded(
                      child: Checkbox(
                        shape: const CircleBorder(),
                        activeColor: Colors.green[200],
                        checkColor: AppColors.white,
                        value: _switchPrivacy,
                        onChanged: (value){
                          setState(() {
                            _switchPrivacy=value!;
                          });
                        },

                      )),
                  const SizedBox(width: 5,),
                  Expanded(
                    flex: 10,
                    child: Text.rich(
                      TextSpan(
                        children: [
                          const TextSpan(
                            text: '我已阅读并接受 WoWoW许愿啦的',
                            style: TextStyle(
                              color: AppColors.font2,
                              fontSize: 12,

                              fontWeight: FontWeight.w400,
                              height: 1.83,
                              letterSpacing: -0.43,
                            ),
                          ),
                          TextSpan(
                            recognizer: TapGestureRecognizer()..onTap=_toPrivacy ,
                            text: '《隐私政策》',
                            style: const TextStyle(
                              color: AppColors.secondary,
                              fontSize: 12,

                              fontWeight: FontWeight.w400,
                              height: 1.83,
                              letterSpacing: -0.43,
                            ),
                          ),
                          const TextSpan(
                            text: '、',
                            style: TextStyle(
                              color: Color(0xFF86A214),
                              fontSize: 12,

                              fontWeight: FontWeight.w400,
                              height: 1.83,
                              letterSpacing: -0.43,
                            ),
                          ),
                          TextSpan(
                            recognizer: TapGestureRecognizer()..onTap=_toTerms ,
                            text: '《条款与条件》',
                            style: const TextStyle(
                              color: AppColors.secondary,
                              fontSize: 12,

                              fontWeight: FontWeight.w400,
                              height: 1.83,
                              letterSpacing: -0.43,
                            ),
                          ),
                        ],
                      ),

                    ),
                  )
                ],
              ),


              Spacer(),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                  onPressed: () async {
                    if(_isIdCodeRight&&_isPhoneNumberRight&&_switchPrivacy){
                      if(logic.definePhoneNumber==logic.mobilePhone&&logic.idCode==logic.defineCode){
                        if(!await logic.isAlreadySignUp()){
                          Get.toNamed(Routes.SETPASSWORD,arguments: logic.mobilePhone);
                        }else{
                          appShowToast('该手机号已注册');
                        }
                      }else{
                        appShowToast('手机号或验证码无效');
                      }
                    }else{
                      appShowToast('请确认以上信息填写无误');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      foregroundColor: AppColors.white,
                    backgroundColor:_isIdCodeRight&&_isPhoneNumberRight&&_switchPrivacy
                        ? Color(0xFF2D2D2D)
                        : Colors.grey[400],
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                          width: 0.48, color: AppColors.borderSideColor),
                      borderRadius: BorderRadius.circular(9),
                    ),
                  ),
                  child: const Text(
                    '注册',
                    style: AppText.subtitle1,
                  ),
                ),
              ),
              SizedBox(height: 15,)
            ],
          ),
        ),
      ),
    );
  }
}
