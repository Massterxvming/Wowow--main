import 'package:flutter/material.dart';
import 'package:wowowwish/styles/app_colors.dart';

import '../../pages/home/logic.dart';

class BottomNavigationItem extends StatelessWidget {
  const BottomNavigationItem(
      {super.key,
      required this.onPress,
      required this.current,
      required this.name});

  final VoidCallback onPress;
  // final String icon;
  final Menus current;
  final Menus name;

  @override
  Widget build(BuildContext context) {
    final nameMap = {
      'wish': '许愿',
      'wishList': '收愿箱',
      'them': 'Ta们',
      'user': '我的',
    };
    final iconsMap = {
      'wish': Icons.home_outlined,
      'wishList': Icons.list_alt_outlined,
      'them': Icons.people_alt_outlined,
      'user': Icons.person_2_outlined,
    };
    return Column(
      children: [
        Container(
          width: 55,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            color: current == name ?  AppColors.bottomNvAndLoading : null,
          ),
          child: IconButton(
            onPressed: onPress,
            icon: Icon(
              iconsMap[name.name],
              fill: 1,
              color: current == name
                  ? Colors.black
                  : Colors.black.withOpacity(0.5),
              size: 28,
            ),
          ),
        ),
        const SizedBox(
          height: 2,
        ),
        Text(
          nameMap[name.name]!,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}
