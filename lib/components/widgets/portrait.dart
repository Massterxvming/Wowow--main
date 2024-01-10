import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wowowwish/styles/app_colors.dart';
class Portrait extends StatelessWidget {
  const Portrait({super.key, required this.size, this.imgUrl, required this.userUid, this.onTap});
  final double size;
  final String? imgUrl;
  final int userUid;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        child: CircleAvatar(
            backgroundColor: AppColors.appBackground,
            radius: size,
            backgroundImage:userUid==-1?const AssetImage('assets/images/null.png',):const AssetImage('assets/images/2.png',),
            foregroundImage:imgUrl==null?null:CachedNetworkImageProvider(imgUrl!)
        ),
      ),
    );
  }
}
