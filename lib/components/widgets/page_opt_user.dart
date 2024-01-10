import 'package:flutter/material.dart';

import '../../styles/app_text.dart';

class PageOpt extends StatelessWidget {
  const PageOpt( {super.key, this.onTap, required this.optName});
  final VoidCallback? onTap;
  final String optName;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      child: ListTile(
        title: Text(
          optName,
          style: AppText.subtitle2,
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
