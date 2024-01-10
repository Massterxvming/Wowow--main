import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wowowwish/components/widgets/app_tool_bar.dart';
import 'package:wowowwish/components/widgets/them_card_block.dart';
import 'package:wowowwish/constants.dart';
import 'package:wowowwish/model/block.dart';
import 'package:wowowwish/request/requests.dart';

import '../../../../components/widgets/REmptyView.dart';
import 'logic.dart';

class BlockUserListPage extends StatefulWidget {
  const BlockUserListPage({Key? key}) : super(key: key);

  @override
  State<BlockUserListPage> createState() => _BlockUserListPageState();
}

class _BlockUserListPageState extends State<BlockUserListPage> {
  final logic = Get.find<BlockUserListLogic>();
  late List blockList;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: ToolBar(title: '黑名单'),
        body: FutureBuilder(
            future: getData(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return const Center(
                    child: REmptyView(dataText: '网络错误\n请检查网络连接'),
                  );
                }else{
                  return blockList.isEmpty
                      ?const Center(child: REmptyView(dataText: '您没有将任何用户拉黑哦')):ListView(
                    children: [
                      for(Block item in blockList)
                        BlockThemCard(blockWithoutThem: item)
                    ],
                  );
                }
              }else{
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }

  getData() async {
     blockList=[];
     blockList=await AppRequest().queryBlockList();
  }
}
