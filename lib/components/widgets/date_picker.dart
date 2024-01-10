import 'package:flutter/material.dart';

import '../../pages/home/user/reminder/view.dart';

showAppDatePicker(BuildContext context) async {
  DateTime now = DateTime.now();
  final DateTime? pickDate = await showDatePicker(
      context: context,
      initialDate: now,
      locale: const Locale('zh','CN'),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
      initialEntryMode: DatePickerEntryMode.calendarOnly
  );
  final finalDate = pickDate?.copyWith(hour: 8,minute: 0);
  return finalDate;
}
