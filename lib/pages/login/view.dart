import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:wowowwish/components/widgets/app_text_field.dart';
import 'package:wowowwish/config/app_toast.dart';
import 'package:wowowwish/routes/app_routes.dart';
import 'package:wowowwish/styles/app_text.dart';
import '../../components/widgets/password_text_field.dart';
import '../../config/app_strings.dart';
import '../../constants.dart';
import '../../request/requests.dart';
import '../../styles/app_colors.dart';
import 'logic.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final logic = Get.put(LoginLogic());
  void _toPrivacy(){
    Get.toNamed(Routes.PRIVACY);
  }
  void _toTerms(){
    Get.toNamed(Routes.TERMS);
  }
  bool _switchPrivacy=false;
  bool _isPasswordLogin=true;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        body: SingleChildScrollView(
          // physics: const NeverScrollableScrollPhysics(),
          child: SizedBox(
            height: MediaQuery
                .of(context)
                .size
                .height,
            child: Padding(
              padding: const EdgeInsets.all(35.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                    child: Image.asset(
                      'assets/images/3.png',
                      width: 100,
                      height: 100,
                    ),
                  ),
                  const SizedBox(height: 5,),
                  const Text('version: 1.3.7'),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(children: [
                    TextButton(onPressed: (){
                      setState(() {
                        _isPasswordLogin=true;
                      });
                  }, child: Text(
                    '密码登录',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: _isPasswordLogin? AppColors.secondary: AppColors.font2,
                      fontSize: 16,

                      fontWeight: FontWeight.w400,
                      height: 1.38,
                      letterSpacing: -0.43,
                    ),
                  ),),
                    TextButton(onPressed: (){
                      setState(() {
                        _isPasswordLogin=false;
                      });
                    }, child: Text(
                      '短信登录',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: !_isPasswordLogin?const Color(0xFF86A214):const Color(0xFF202020),
                        fontSize: 16,

                        fontWeight: FontWeight.w400,
                        height: 1.38,
                        letterSpacing: -0.43,
                      ),
                    ),),
                  ],),
                  _isPasswordLogin
                      ?Column(
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
                      AppPasswordTextField(
                        keyboardType: TextInputType.visiblePassword,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9a-zA-Z!@#%^&*()\$,.?":{}|<>]'))
                        ],
                        labelText: '请输入密码',
                        hint: AppStrings.password,
                        onChanged: (value) {
                          logic.password = value;//实时记录密码
                        },
                      ),
                    ],
                  )
                      :Column(
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
                                labelText: '请输入验证码',
                                maxLength: 6,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                                ],
                                onChanged: (val) {
                                  logic.idCode = val;
                                },
                              )),
                          const SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            flex: 4,
                            child: SizedBox(
                              height: 62,
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
                                    if(isChinesePhoneNumber(logic.phoneNumber)){
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
                    ],
                  )
                  ,
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
                                  color: Color(0xFF404040),
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
                                  color: Color(0xFF86A214),
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
                                  color: Color(0xFF86A214),
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
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: ElevatedButton(
                      onPressed: () async {
                        if(_switchPrivacy){
                          logic.showLoading();
                          if(_isPasswordLogin){
                            await logic.doLogin();
                          }else{
                              await logic.doLoginWithVerifyCode();
                          }
                          logic.hideLoading();
                        }else{
                          appShowToast('请勾选上方协议');
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                              width: 0.48, color: AppColors.borderSideColor),
                          borderRadius: BorderRadius.circular(9),
                        ),
                          foregroundColor: AppColors.white,
                          backgroundColor:_switchPrivacy? const Color(0xFF373737):const Color(0xFFBFC1B8)),
                      child: const Text(
                          AppStrings.login,
                          style: AppText.subtitle1,
                        ),


                    ),
                  ),
                  const SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          logic.doSignUp();
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: AppColors.black,
                        ),
                        child: const Text(
                          '现在注册',
                          style: TextStyle(
                            color: Color(0xFF86A214),
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            height: 1.69,
                            letterSpacing: -0.43,
                          ),
                        ),
                      ),
                      Container(
                        width: 1,
                        height: 14,
                        decoration: const BoxDecoration(color: Color(0xFF676767)),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.toNamed(Routes.FORGET);
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: AppColors.black,
                        ),
                        child: const Text(
                          AppStrings.forgetPassword,
                          style: TextStyle(
                            color: Color(0xFF86A214),
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            height: 1.69,
                            letterSpacing: -0.43,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  int seconds=60;
  Timer? _getCodeTimer;
  String text = '发送验证码';
  bool _isGetCodeActive = true;
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
}
