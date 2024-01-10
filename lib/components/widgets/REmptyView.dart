import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wowowwish/styles/app_colors.dart';

class REmptyView extends StatelessWidget {
  const REmptyView({super.key, required this.dataText});
  final String dataText;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/images/bk_null.svg',color: AppColors.hintColor,),
            const SizedBox(
              height: 15,
            ),
            Text(
              dataText,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.hintColor,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
      ),
    );
  }
}