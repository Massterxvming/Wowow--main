import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wowowwish/styles/app_colors.dart';
import '../../model/wish.dart';
import '../searchable_listview/searchable_listview.dart';
import '../widgets/empty_view.dart';
import '../widgets/wish_card_mine.dart';
import 'logic.dart';

class MyWishListComponent extends StatefulWidget {
  const MyWishListComponent(
      {Key? key, required this.myWishList, required this.objectUid})
      : super(key: key);
  final int objectUid;
  final List myWishList;
  @override
  State<MyWishListComponent> createState() => _MyWishListComponentState();
}

class _MyWishListComponentState extends State<MyWishListComponent> {
  final logic = Get.put(MyWishListLogic());//设置页面状态为statefulwidget刷新

  @override
  Widget build(BuildContext context) {
    List<Wish> wishes = [];
    if(widget.myWishList!=[]){
      for (var item in widget.myWishList) {
        wishes.add(Wish(
            item['uid'],
            item['subject_useruid'],
            item['pub_date'],
            item['read'],
            item['object_useruid'],
            item['content'],
            item['status'],
            item['wish_pics'],
            item['start_date'],
            item['update_date'],
            item['username'],
            item['portrait']));
      }
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 420,
        child: SearchableList<Wish>(
          autoFocusOnSearch: false,
          initialList: wishes,
          style: const TextStyle(
              fontSize: 14
          ),
          //   onPaginate: ()async{
          //     await Future.delayed(Duration(milliseconds: 1000),);
          //   },
          // asyncListCallback: ()async{
          //     await Future.delayed(Duration(milliseconds: 5000),);
          //     return wishes;
          // },
          builder: (Wish wish) => MyWishCard(
            wish: wish,
          ),
          filter: (value) => wishes.where(
                (element) => element.content.contains(value),
              ).toList(),
          emptyWidget: const EmptyView(),
          spaceBetweenSearchAndList: 10,
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
              borderSide:  BorderSide(
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

// class Wish {
//   String? content;
//   String? status;
//   Wish(this.content, this.status);
// }
// Container(
// height: 434,
// child: ListView(
// children: [
//
// for(Map item in myWishList)
// MyWishCard(status: item['status'],postText: item['content'],)
// ],
// ),
// );
