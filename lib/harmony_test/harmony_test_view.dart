import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'harmony_test_logic.dart';

class Harmony_testPage extends StatelessWidget {
  const Harmony_testPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<Harmony_testLogic>();
    final state = Get.find<Harmony_testLogic>().state;

    return Container();
  }
}
