


import 'package:flutter/material.dart';

Future<TimeOfDay?> showAppTimePicker(BuildContext context)async {
  TimeOfDay now=TimeOfDay.now();
  final TimeOfDay? pickTime=await showTimePicker(context: context, initialTime: now);
  return pickTime;
}