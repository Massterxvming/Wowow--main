import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wowowwish/components/widgets/app_tool_bar.dart';
import 'package:wowowwish/config/app_strings.dart';
import '../../../components/widgets/app_text_field.dart';
import '../../../config/app_toast.dart';
import '../../../styles/app_colors.dart';
import '../../../styles/app_style.dart';
import '../../../styles/app_text.dart';
import '../wish/logic.dart';
import 'logic.dart';

class WishToPage extends StatefulWidget {
  const WishToPage({Key? key}) : super(key: key);

  @override
  State<WishToPage> createState() => _WishToPageState();
}

class _WishToPageState extends State<WishToPage> {
  final wishLogic = Get.find<WishLogic>();
  final logic = Get.put(WishToLogic());
  File? imageSelect;
  bool flag = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ToolBar(title: AppStrings.wish),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: SizedBox(
            height: Get.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 25,),
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      Container(
                        decoration: const ShapeDecoration(
                          color: AppColors.appBackground,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(width: 0.48, color: AppColors.borderSideColor),
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                          ),
                          shadows: [
                            BoxShadow(
                              color: AppColors.shadowColor,
                              blurRadius: 10,
                              offset: Offset(0, 2),
                              spreadRadius: 0,
                            )
                          ],
                        ),
                        child: Column(
                          children: [
                            // const SizedBox(height: 13,),
                            Obx(()=>TextField(
                              cursorColor: Colors.grey,
                              onChanged: (value) {
                                logic.saveContent(value);
                              },
                              decoration: InputDecoration(
                                hintStyle: const TextStyle(
                                  color: AppColors.hintColor
                                ),
                                hintText: '向${logic.postTitle.value}许愿吧！',
                                border: InputBorder.none,
                                filled: true,
                                fillColor: AppColors.appBackground,
                              ),
                              maxLength: 40,
                              maxLines: 3,
                            ),),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Stack(
                                  children: [
                                    SizedBox(
                                      width: 90,
                                      height: 90,
                                      child: imageSelect==null
                                          ? Center(
                                        child: IconButton(
                                            onPressed: () async {
                                              PermissionStatus status = await Permission.photos.status;
                                              if(!status.isGranted){
                                                status = await Permission.photos.request();
                                              }
                                              final ImagePicker imagePicker = ImagePicker();
                                              XFile? image1 = await imagePicker.pickImage(
                                                  source: ImageSource.gallery,
                                                  maxHeight: 1080,
                                                  maxWidth: 1080
                                              );
                                              if (image1 != null) {
                                                setState(() {
                                                  imageSelect=File(image1.path);
                                                });
                                              }else{
                                                appShowToast('已取消');
                                              }
                                            },
                                            icon: const Icon(
                                              Icons.add_photo_alternate_outlined,
                                              size: 70,
                                            )),
                                      )
                                          :Center(
                                        child: Container(
                                          width: 70,
                                          height: 70,
                                          clipBehavior: Clip.antiAlias,
                                          decoration: ShapeDecoration(
                                            image: DecorationImage(
                                              image: FileImage(imageSelect!),
                                              fit: BoxFit.fill,
                                            ),
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
                                          ),
                                        ),
                                      ),
                                    ),
                                    imageSelect!=null
                                        ?Positioned(
                                      top: 5,
                                      right: 5,
                                      child:GestureDetector(
                                          onTap: (){
                                            setState(() {
                                              imageSelect=null;
                                            });
                                          },
                                          child: Icon(Icons.cancel,color: Colors.grey,size: 20,)) ,
                                    )
                                        :Container(),
                                  ],
                                ),
                                const Spacer(),
                                IconButton(
                                    onPressed: () async {
                                      PermissionStatus status =await Permission.camera.status;
                                      if(!status.isGranted){
                                        status = await Permission.camera.request(
                                        );
                                      }
                                      final ImagePicker imagePicker =
                                      ImagePicker();
                                      XFile? image1 =
                                      await imagePicker.pickImage(
                                          source: ImageSource.camera,
                                          maxHeight: 1080,
                                          maxWidth: 1080
                                      );
                                      if (image1 != null) {
                                        setState(() {
                                          imageSelect =
                                              File(image1.path);
                                        });
                                      } else {
                                        appShowToast('已取消');
                                      }
                                    },
                                    icon: const Icon(
                                      Icons.camera_alt_outlined,
                                      size: 25,
                                    )),
                                IconButton(
                                    onPressed: () {
                                      FocusScope.of(context).requestFocus(FocusNode());
                                    },
                                    icon: const Icon(
                                      Icons.keyboard_hide_outlined,
                                      size: 25,
                                    )),
                                SizedBox(width: 5,),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 60,),
                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: () async {
                      logic.showLoading();
                      logic.picUrl=imageSelect==null?null:imageSelect!.path;
                      await logic.onSend();
                      logic.hideLoading();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.buttonSend,
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                            width: 0.48, color: AppColors.borderSideColor),
                        borderRadius: BorderRadius.circular(9),
                      ),
                    ),
                    child: const Text(
                      '发 送',
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
