import 'package:flutter/material.dart';
import '../../model/wanna.dart';
import '../../styles/app_colors.dart';
class WannaCard extends StatelessWidget {
  const WannaCard({super.key, required this.wanna});
  final Wanna wanna;
  @override
  Widget build(BuildContext context) {
    return wanna.wannaPics == ""
        ? Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 136,
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: AppColors.appBackground,
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 0.50, color: AppColors.borderSideColor),
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        child:  Center(
          child: Text(
            wanna.content,
            textAlign: TextAlign.center,
            style:  TextStyle(
              color: AppColors.font,
              fontSize: 15,

              fontWeight: FontWeight.w700,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    )
        : Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 136,
        decoration: BoxDecoration(
          boxShadow:  [
            BoxShadow(
              color: AppColors.shadowColor,
              blurRadius: 10,
              offset: Offset(0, 2),
              spreadRadius: 0,
            )
          ],
          image: DecorationImage(
              image: NetworkImage(wanna.wannaPics),
              fit: BoxFit.cover),
          borderRadius: const BorderRadius.all(Radius.circular(6)),
        ),
        child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                color: const Color(0x66171717),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    height: 30,
                    padding: const EdgeInsets.only(top: 6),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          wanna.content,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,

                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
      ),
    );
  }
}
