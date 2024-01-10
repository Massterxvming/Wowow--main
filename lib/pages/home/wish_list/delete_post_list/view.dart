// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:wowowwish/components/widgets/delete_post_with_img.dart';
//
//
// import '../../../../components/widgets/app_tool_bar.dart';
//
// import '../../../../components/widgets/delete_post_without_img.dart';
// import '../../../../components/widgets/post_item_with_img.dart';
// import '../logic.dart';
// import 'logic.dart';
//
// class DeletePostListPage extends StatelessWidget {
//   DeletePostListPage({Key? key}) : super(key: key);
//   final postLogic = Get.find<WishListLogic>();
//   final logic = Get.put(DeletePostListLogic());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: const ToolBar(
//         title: '撤回历史',
//
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: ListView(
//           children: [
//             Container(height: 25,width: 25,color: Colors.blueAccent,),
//             for (var postItem in logic.savedeleteList)
//               if (postItem['withImg'])
//                 PostItem(
//                   postImg: postItem['postImg'],
//                   username: postItem['username'],
//                   postTime: postItem['postTime'],
//                   postText: postItem['postText'],
//                   posterAvatar: postItem['posterAvatar'],
//                 )
//               else
//                 PostItemWithoutImg(
//                     username: postItem['username'],
//                     postTime: postItem['postTime'],
//                     postText: postItem['postText'],
//                     posterAvatar: postItem['posterAvatar'])
//             // DeletePostWithoutImg(
//             //   deleteTime: logic.savedeleteList[1]['deleteTime']!,
//             //   postText: 'iyhdiuqwhfuqf')
//             // for (var postItem in logic.savedeleteList)
//               // if (postItem['withImg'])
//               //   DeletePost(
//               //     postImg: postItem['imgUrl'],
//               //     deleteTime: postItem['deleteTime'],
//               //     postText: postItem['postText'],
//               //   )
//               // else
//               //   DeletePostWithoutImg(
//               //       deleteTime: postItem['postTime'],
//               //       postText: postItem['postText'],)
//           ],
//         ),
//       ),
//     );
//   }
// }
