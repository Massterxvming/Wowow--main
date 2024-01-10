import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wowowwish/components/widgets/app_tool_bar.dart';
import 'package:wowowwish/components/widgets/searchable_wanna_list.dart';
import 'package:wowowwish/config/app_strings.dart';
import 'package:wowowwish/styles/app_colors.dart';
import 'logic.dart';

class WannaListPage extends StatefulWidget {
  const WannaListPage({Key? key}) : super(key: key);

  @override
  State<WannaListPage> createState() => _WannaListPageState();
}

class _WannaListPageState extends State<WannaListPage> {
  final logic = Get.find<WannaListLogic>();

  Status currentIndex = Status.all;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar:  const ToolBar(
          title: AppStrings.want,
        ),
        body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                WannaStatusSelect(currentIndex: currentIndex, onTap: (value){
                  setState(() {
                    logic.onInit();
                    currentIndex=value;
                  });
                }),
                SearchableWannaList(wannaList: logic.map[currentIndex]),
              ],
            )),
      ),
    );
  }
}


class WannaStatusSelect extends StatelessWidget {
  const WannaStatusSelect(
      {super.key, required this.currentIndex, required this.onTap});
  final Status currentIndex;
  final ValueChanged<Status> onTap;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          WannaStatusItem(
              onPress: () => onTap(Status.all),
              // icon: AppIcons.icWishList,
              current: currentIndex,
              name: Status.all),
          WannaStatusItem(
              onPress: () => onTap(Status.ongoing),
              // icon: AppIcons.icThem,
              current: currentIndex,
              name: Status.ongoing),
          WannaStatusItem(
              onPress: () => onTap(Status.done),
              // icon: AppIcons.icUser,
              current: currentIndex,
              name: Status.done),
        ],
      ),
    );
  }
}


class WannaStatusItem extends StatelessWidget {
  const WannaStatusItem(
      {super.key,
        required this.onPress,
        required this.current,
        required this.name});

  final VoidCallback onPress;
  final Status current;
  final Status name;

  @override
  Widget build(BuildContext context) {
    final nameMap = {
      'all': '所有',
      'ongoing': '进行中',
      'done': '已完成',
    };
    return Column(
      children: [
        Container(
          width: 90,
          height: 37,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(Radius.circular(15)),
            color: current == name ? AppColors.bottomNvAndLoading : null,
          ),
          child: TextButton(
            onPressed: onPress,
            child: Text(nameMap[name.name]!,style:const TextStyle(
              color: AppColors.black,
              fontSize: 16,

              fontWeight: FontWeight.w600,
            ),),
          ),
        ),
      ],
    );
  }
}
