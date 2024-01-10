import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wowowwish/styles/app_colors.dart';

class ToolBar extends StatelessWidget implements PreferredSizeWidget {
  const ToolBar(
      {super.key,
      required this.title,
      this.actions,
      this.leading,
      this.bottom});
  final String title;
  final List<Widget>? actions;
  final Widget? leading;
  final PreferredSizeWidget? bottom;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: leading,
      title: Text(
        title,
        style: const TextStyle(
          color: AppColors.font2,
          fontSize: 18,

          fontWeight: FontWeight.w600,
          height: 0.07,
          letterSpacing: -0.43,
        ),
      ),
      backgroundColor: AppColors.appBackground,
      actions: actions,
      scrolledUnderElevation: 0,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(60);
}
