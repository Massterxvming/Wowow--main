import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wowowwish/components/widgets/app_tool_bar.dart';
import 'package:wowowwish/model/wish.dart';
import 'package:wowowwish/request/requests.dart';
import 'package:wowowwish/wish_counter_logic.dart';
import '../../../components/searchable_listview/searchable_listview.dart';
import '../../../components/widgets/REmptyView.dart';
import '../../../components/widgets/post_item_from_friend.dart';
import '../../../constants.dart';
import '../../../styles/app_colors.dart';
import 'logic.dart';

class WishListPage extends StatefulWidget {
  const WishListPage({Key? key}) : super(key: key);
  @override
  State<WishListPage> createState() => _WishListPageState();
}

class _WishListPageState extends State<WishListPage> {
  final WishCounterLogic wishCounterLogic = Get.find<WishCounterLogic>();
  @override
  void initState() {
    for (var item in logic.postList) {
      logic.friendWishList.add(Wish.fromJson(item));
    }
    super.initState();
  }

  final logic = Get.put(WishListLogic());
  @override
  Widget build(BuildContext context) {
    updateBox();

    return Scaffold(
      appBar: const ToolBar(
        title: '收愿箱',
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: RefreshIndicator(
          backgroundColor: AppColors.appBackground,
          color: Colors.green[200],
          onRefresh: refreshData,
          child:FutureBuilder(
            future: getData(),
            builder: (context,snapshot){
              if(snapshot.connectionState==ConnectionState.done){
                if(snapshot.hasError){
                  return const Center(
                    child: REmptyView(dataText: '网络错误\n请检查网络连接'),
                  );
                }else{
                  return SearchableList<Wish>(
                    autoFocusOnSearch: false,
                    initialList: logic.friendWishList,
                    style: const TextStyle(fontSize: 14),
                    builder: (Wish f) => PostItem(
                      friendWish: f,
                    ),
                    filter: (value) => logic.friendWishList
                        .where(
                          (element) =>
                      element.content.contains(value)
                    )
                        .toList(),
                    emptyWidget: const REmptyView(dataText: '收愿箱暂无您要查找的愿望',),
                    spaceBetweenSearchAndList: 5,
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
                    textAlign: TextAlign.center,
                    inputDecoration:InputDecoration(
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
                  );
                }
              }else{
                return const Center(child: CircularProgressIndicator());
              }
            },
          )


        ),
      ),
    );
  }
  Future refreshData() async {
    clearWishCount();
    await getData();
    setState(() {
    });
  }
  Future getData() {
    return Future(() async {
      Map postItem = await AppRequest().getWishesToMe(boxAccount.read('user_uid'));
      List listOld=postItem['data'];
      List<int> blockUserIdList=await AppRequest().queryBlockListUserIdList();
      List list=[];
      for(var item in listOld){
        if(!blockUserIdList.contains(item['subject_useruid'])){
          list.add(item);
        }
      }
      list.sort(
            (a, b) => DateTime.parse(b['pub_date']).compareTo(
          DateTime.parse(a['pub_date']),
        ),
      );
      box.write('post', list);
      logic.postList = list;
      logic.friendWishList = <Wish>[];
      for (var item in logic.postList) {
        logic.friendWishList.add(Wish.fromJson(item));
        }
      },
    );
  }
}
