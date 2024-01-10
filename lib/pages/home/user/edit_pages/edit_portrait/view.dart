import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wowowwish/components/widgets/app_tool_bar.dart';
import 'package:wowowwish/config/app_toast.dart';
import 'package:wowowwish/constants.dart';
import 'package:wowowwish/styles/app_style.dart';

import '../../../../../components/widgets/post_item_from_friend.dart';
import '../../../../../request/app_request.dart';
import '../../../../../styles/app_colors.dart';
import '../../logic.dart';
import 'logic.dart';

class EditPortraitPage extends StatefulWidget {
  const EditPortraitPage({Key? key}) : super(key: key);
  @override
  State<EditPortraitPage> createState() => _EditPortraitPageState();
}

class _EditPortraitPageState extends State<EditPortraitPage> {
  final logic = Get.find<EditPortraitLogic>();
  var file;
  bool flag = false;
  var sendImgPath = '';
  String? imageSelect = boxAccount.read('portrait');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ToolBar(title: '用户头像'),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              Container(
                  height: Get.width * 0.75,
                  width: Get.width * 0.75,
                  decoration: AppStyle.shapeDecoration,
                  child: flag == true
                      ? Image(image: FileImage(file),fit: BoxFit.cover,)
                      : imageSelect == null
                          ? GestureDetector(
                              onTap: () {
                                appShowToast('请设置头像');
                              },
                              child: const Image(
                                  image: AssetImage('assets/images/2.png')))
                          : GestureDetector(
                              onTap: () {
                                showDialog<void>(
                                  context: context,
                                  barrierColor: AppColors.black,
                                  builder: (BuildContext dialogContext) {
                                    return ZoomableImage(
                                      imageUrl: imageSelect!,
                                    );
                                  },
                                );
                              },
                              child: Image(
                                  image: CachedNetworkImageProvider(
                                      imageSelect!)))),
              Spacer(),
              SizedBox(
                width: Get.width * 0.9,
                height: 48,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.blackElevated,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 0.48, color: AppColors.borderSideColor),
                        borderRadius: BorderRadius.circular(9),
                      ),
                    ),
                    onPressed: () async {
                      final ImagePicker imagePicker = ImagePicker();
                      XFile? image1 = await imagePicker.pickImage(
                          source: ImageSource.gallery,
                          maxWidth: 1080,
                          maxHeight: 1080);
                      if (image1 != null) {
                        print(image1.path);
                        CroppedFile? croppedFile =
                            await ImageCropper().cropImage(
                              aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
                          sourcePath: image1.path,
                          aspectRatioPresets: [CropAspectRatioPreset.square],
                          uiSettings: [
                            AndroidUiSettings(
                                toolbarTitle: '裁剪',
                                toolbarColor: AppColors.appBackground,
                                toolbarWidgetColor: Colors.black,
                                statusBarColor: AppColors.appBackground,
                                cropGridColor:AppColors.appBackground,
                                activeControlsWidgetColor: AppColors.secondary,
                                initAspectRatio: CropAspectRatioPreset.square,
                                lockAspectRatio: true),
                            IOSUiSettings(
                              minimumAspectRatio: 1,
                              title: '裁剪',
                              aspectRatioLockEnabled: true,
                              resetButtonHidden: true,
                              aspectRatioPickerButtonHidden: true,
                              doneButtonTitle: '确认',
                              cancelButtonTitle: '取消',

                            ),
                          ],
                        );
                        if (croppedFile != null) {
                          setState(() {
                            flag = true;
                            imageSelect = image1.path;
                            sendImgPath = croppedFile.path;
                            file = File(sendImgPath);
                          });
                        }
                      } else {
                        print('未选择');
                      }
                    },
                    child: const Text(
                      '选择图片',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,

                        fontWeight: FontWeight.w600,
                      ),
                    )),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: Get.width * 0.9,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.blackElevated,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 0.48, color: AppColors.borderSideColor),
                      borderRadius: BorderRadius.circular(9),
                    ),
                  ),
                  onPressed: () async {
                    logic.showLoading();
                    if (sendImgPath != '') {
                      Dio dio = AppRequestType()
                          .getDioWithToken(boxAccount.read('token'));
                      var saveImg = '';
                      final fromData = FormData.fromMap({
                        "user_uid": boxAccount.read('user_uid'),
                        "file": await MultipartFile.fromFile(sendImgPath)
                      });
                      var saveImgResponse =
                          await dio.post('/images', data: fromData);
                      saveImg = 'http://114.116.111.148:8081/qualia/img/';
                      saveImg += saveImgResponse.data['data']['dir'];
                      print(saveImg);
                      var sendResponse = await dio.put('/users', data: {
                        "user_uid": boxAccount.read('user_uid'),
                        "edit_param": 3,
                        "portrait": saveImg,
                      });
                      if (sendResponse.data['code'] == '000001') {
                        appShowToast('修改成功');
                        await boxAccount.write('portrait', saveImg);
                        Get.back();
                        var logicSuper = Get.find<UserLogic>();
                        logicSuper.updatePortrait();
                        logicSuper.onInit();
                      }
                    }
                    else{
                      appShowToast('您未作出任何更改');
                    }
                    logic.hideLoading();
                    Get.back();
                  },
                  child: Text(
                    '确定',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,

                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
SizedBox(height: 15,)            ],
          ),
        ),
      ),
    );
  }
}
