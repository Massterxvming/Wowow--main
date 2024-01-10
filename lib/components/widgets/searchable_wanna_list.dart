import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wowowwish/components/widgets/wanna_card_mine.dart';
import 'package:wowowwish/styles/app_colors.dart';

import '../../model/wanna.dart';
import '../searchable_listview/searchable_listview.dart';
import 'REmptyView.dart';

class SearchableWannaList extends StatelessWidget {
  const SearchableWannaList({super.key, required this.wannaList});
  final List<Wanna>? wannaList;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0,left: 8,right: 8),
      child: SizedBox(
        height: Get.height-170,
        child: SearchableList<Wanna>(
          autoFocusOnSearch: false,
          initialList: wannaList,
          style: const TextStyle(fontSize: 14),
          builder: (Wanna f) => MyWannaCard(
            myWanna: f,
          ),
          filter: (value) => wannaList!
              .where(
                (element) =>
                element.content.contains(value),
          )
              .toList(),
          emptyWidget: const REmptyView(dataText: '暂时没有您查找的"想要"',),
          spaceBetweenSearchAndList: 15,
          loadingWidget: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(
                height: 20,
              ),
              Text('加载中...'),
            ],
          ),
          inputDecoration: InputDecoration(
            labelText: "搜索",
            filled: true,
            fillColor: AppColors.fieldColor,
            border: const OutlineInputBorder(),
            enabledBorder:  OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.fieldColor,
                width: 1.0,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.fieldColor,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
      ),
    );
  }
}
