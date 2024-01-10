import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wowowwish/styles/app_colors.dart';

class NullView extends StatelessWidget {
  const NullView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
          height: 420,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // const Spacer(),
                SvgPicture.asset('assets/images/bk_null.svg',color: AppColors.hintColor,),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  '暂无好友信息\n点击下方卡片添加好友吧',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.hintColor,
                    fontSize: 14,

                    fontWeight: FontWeight.w500,
                  ),
                ),
                // const Spacer(),
              ],
            ),
          )),
    );

  }
}
