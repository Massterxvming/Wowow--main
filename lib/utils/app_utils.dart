import 'dart:io';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wowowwish/config/app_toast.dart';

import '../styles/app_colors.dart';

appShowDialog(BuildContext context,String title,String content,String cancelText,String confirmText,VoidCallback confirm){
  showDialog<void>(
    context: context,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        backgroundColor: AppColors.dialog,
        title: Text(title),
        titleTextStyle: const TextStyle(
          color: Color(0xFF1D1B20),
          fontSize: 24,
          fontWeight: FontWeight.w400,
        ),
        content:  Text(content),
        contentPadding: const EdgeInsets.only(left: 50,top: 25,bottom: 15,right: 50),
        contentTextStyle: const TextStyle(
          color: Color(0xFF1D1B20),
          fontSize: 17,

          fontWeight: FontWeight.w400,
        ),
        actions: <Widget>[
          SizedBox(
            width: double.infinity,
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  child:  Text(
                    cancelText,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                  onPressed: () {
                    Get.back();
                  },
                ),
                TextButton(
                  onPressed: confirm,
                  child:  Text(
                    confirmText,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    },
  );
}

class SharePosterUtils {

  static Future<ByteData?> getWidgetToImageByteData(
      GlobalKey repaintKey) async {
    PermissionStatus status = await Permission.storage.status;//存储权限
    print(status.isGranted);
    if (!status.isGranted) {
      status = await Permission.storage.request();
    }
    BuildContext? buildContext = repaintKey.currentContext;
    print(buildContext);
    if (null != buildContext) {
      RenderRepaintBoundary? boundary =
      buildContext.findRenderObject() as RenderRepaintBoundary?;
      ui.Image? image = await boundary?.toImage(pixelRatio: 3.0);
      ByteData? byteData =
      await image?.toByteData(format: ui.ImageByteFormat.png);
      if (byteData == null) {
        EasyLoading.show(status: '保存失败, == >>> 获取 image.toByteData 失败');
        return null;
      } else {
        return byteData;
      }
    }
    return null;
  }

  static Future<String?> getImageFilePath(GlobalKey repaintKey) async {
    ByteData? byteData = await SharePosterUtils.getWidgetToImageByteData(repaintKey);
    if (byteData == null) {
      print('获取 byteData 失败 ');
      return null;
    }
    Uint8List imageByte = byteData.buffer.asUint8List();
    var tempDir = await getTemporaryDirectory();
    var file = await File('${tempDir.path}/image_${DateTime.now().millisecond}.jpg').create();
    file.writeAsBytesSync(imageByte);
    return file.path;
  }


  static savePosterImage(GlobalKey repaintKey) async {
    ByteData? byteData = await SharePosterUtils.getWidgetToImageByteData(repaintKey);
    if (byteData == null) {
      print('获取 byteData 失败 ');
      return;
    }
    final result = await ImageGallerySaver.saveImage(byteData.buffer.asUint8List());
    if (result['isSuccess']) {
      appShowToast('保存成功');
    } else {
      appShowToast('保存失败');
    }
  }

}

