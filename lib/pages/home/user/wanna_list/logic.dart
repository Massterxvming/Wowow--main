import 'package:get/get.dart';
import 'package:wowowwish/model/wanna.dart';

import '../../../../constants.dart';

enum Status {
  all,
  ongoing,
  done,
}

class WannaListLogic extends GetxController {
  List listWannaJson = [];
  List listOngoingWannaJson = [];
  List listDoneWannaJson = [];
  late List<Wanna> myWannaList;
  late List<Wanna> myOngoingWannaList;
  late List<Wanna> myDoneWannaList;
  Map<Status, List<Wanna>> map = {};
  @override
  void onInit() {
    listWannaJson = box.read('all_wanna');
    listOngoingWannaJson = box.read('ongoing_wanna');
    listDoneWannaJson = box.read('done_wanna');
    myWannaList = <Wanna>[];
    myOngoingWannaList = <Wanna>[];
    myDoneWannaList = <Wanna>[];
    for (var json in listWannaJson) {
      myWannaList.add(Wanna.fromJson(json));
    }
    for (var json in listOngoingWannaJson) {
      myOngoingWannaList.add(Wanna.fromJson(json));
    }
    for (var json in listDoneWannaJson) {
      myDoneWannaList.add(Wanna.fromJson(json));
    }
    map = {
      Status.all: myWannaList,
      Status.ongoing: myOngoingWannaList,
      Status.done: myDoneWannaList
    };
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
