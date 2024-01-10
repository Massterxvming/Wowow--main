import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wowowwish/styles/app_colors.dart';

class EmptyView extends StatelessWidget {
  const EmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
          Spacer(),
              SvgPicture.asset('assets/images/bk_null.svg',color: AppColors.hintColor,),
              const SizedBox(
                height: 15,
              ),
              const Text(
                '您还没有许过愿望\n点击下方卡片许愿吧',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.hintColor,
                  fontSize: 14,

                  fontWeight: FontWeight.w500,
                ),
              ),
              Spacer(),
            ],
          ),
        ));

  }
}
