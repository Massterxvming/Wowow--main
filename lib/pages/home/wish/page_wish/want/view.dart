import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../../components/widgets/app_tool_bar.dart';
import '../../../../../config/app_strings.dart';
import '../../../../../config/app_toast.dart';
import '../../../../../styles/app_colors.dart';
import '../../../../../styles/app_text.dart';
import '../../logic.dart';
import 'logic.dart';

class WantPage extends StatefulWidget {
  const WantPage({Key? key}) : super(key: key);

  @override
  State<WantPage> createState() => _WantPageState();
}

class _WantPageState extends State<WantPage> {
  final logic = Get.find<WantLogic>();
  final wishLogic = Get.find<WishLogic>();
  bool flag = false;

  var imageSelect=null;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ToolBar(title: AppStrings.want),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: SizedBox(
            height: Get.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 25,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Container(
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
                        // SizedBox(height:5 ,),
                        TextField(
                          cursorColor: Colors.grey,
                          onChanged: (value) {
                            logic.saveContent(value);
                          },
                          decoration: const InputDecoration(
                            hintStyle: TextStyle(color: AppColors.hintColor),//
                            hintText:
                            "让您的\"想要\"被看见\n部分话语，或许适合保留",
                            border: InputBorder.none,
                            filled: true,
                            fillColor: AppColors.appBackground,
                          ),
                          maxLines: 3,
                          maxLength: 40,
                        ),
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
                                      child: const Icon(Icons.cancel,color: Colors.grey,size: 20,)) ,
                                )
                                    :Container(),
                              ],
                            ),
                            const Spacer(),
                            IconButton(
                                onPressed: () async {
                                  PermissionStatus status =await Permission.camera.status;
                                  if(!status.isGranted){
                                    status = await Permission.camera.request();
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
                ),
                const SizedBox(
                  height: 60,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: () async {
                      logic.showLoading();
                      logic.picUrl = imageSelect==null?imageSelect:imageSelect.path;
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
