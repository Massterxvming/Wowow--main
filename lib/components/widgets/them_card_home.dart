import 'package:flutter/material.dart';
import 'package:wowowwish/components/widgets/portrait.dart';
import 'package:wowowwish/pages/home/wish/logic.dart';
import 'package:wowowwish/styles/app_colors.dart';
class HomeUserCard extends StatelessWidget {
  HomeUserCard({super.key, required this.onTap, required this.current, required this.name, this.portrait, required this.userUid});
  final VoidCallback onTap;
  final Them current;
  final Them name;
  final String? portrait;
  final int userUid;
  final nameMap = {
    'gene': '血缘的我',
    'lover': '爱情的我',
    'friend': '朋友的我',
  };
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          width: current==name?118:112.26,
          height: current==name?132:125.16,
          padding: const EdgeInsets.only(
            top: 5,
            left: 5,
            right: 5,
            bottom:5,
          ),
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            color:  AppColors.appBackground,
            shape: RoundedRectangleBorder(
              side: BorderSide(width: 0.48, color: AppColors.borderSideColor),
              borderRadius: BorderRadius.circular(12.58),
            ),
            shadows: [
              current==name? BoxShadow(
                color: AppColors.shadowColor,
                blurRadius: 9.68,
                offset: Offset(0, 1.94),
                spreadRadius: 0,
              ): BoxShadow()
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Portrait(size: 25, userUid: userUid,imgUrl: portrait,),
              const SizedBox(height: 19.35),
              Text(
                nameMap[name.name]!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: AppColors.black,
                  fontSize: 11.61,

                  fontWeight: FontWeight.w400,
                  height: 1.83,
                  letterSpacing: -0.42,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
