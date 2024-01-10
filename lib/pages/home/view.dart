import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wowowwish/pages/home/them/view.dart';
import 'package:wowowwish/pages/home/user/view.dart';
import 'package:wowowwish/pages/home/wish/view.dart';
import 'package:wowowwish/pages/home/wish_list/view.dart';
import 'package:wowowwish/styles/app_colors.dart';
import 'package:wowowwish/wish_counter_logic.dart';
import '../../components/widgets/home_page_tabview.dart';

import '../../constants.dart';
import 'logic.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, this.menus}) : super(key: key);
  final Menus? menus;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final homeLogic = Get.put(HomeLogic());
  late Menus currentIndex;
  final pages = [
    WishPage(),
    WishListPage(),
    ThemPage(),
    UserPage(),
  ];

  @override
  void initState() {
    currentIndex = (widget.menus ?? Menus.wish);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: pages[currentIndex.index],
      bottomNavigationBar: MyBottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
      ),
    );
  }
}



class MyBottomNavigationBar extends StatelessWidget {
  MyBottomNavigationBar(
      {super.key, required this.currentIndex, required this.onTap});

  final WishCounterLogic wishCounterLogic = Get.find<WishCounterLogic>();
  final Menus currentIndex;
  final ValueChanged<Menus> onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 86,
      decoration: const BoxDecoration(
        color: AppColors.appBackground,
        border: Border(
          top: BorderSide(
            width: 1,
            color: Color(0xFFD3D6CB),
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Spacer(),
            Expanded(
              flex: 2,
              child: BottomNavigationItem(
                  onPress: () => onTap(Menus.wish),
                  // icon: AppIcons.icWish,
                  current: currentIndex,
                  name: Menus.wish),
            ),
            Spacer(),
            Expanded(
              flex: 2,
              child: Obx(() {
                return Stack(
                  children: [
                    BottomNavigationItem(
                        onPress: () {
                          onTap(Menus.wishList);
                          wishCounterLogic.wishCount.value = 0;
                          box.write('wishCount', 0);
                        },
                        // icon: AppIcons.icWishList,
                        current: currentIndex,
                        name: Menus.wishList),
                    wishCounterLogic.wishCount.value != 0
                        ? Positioned(
                            top: 0,
                            right: 5,
                            child: CircleAvatar(
                              radius: 9,
                              backgroundColor: Color(0xFFC93F37),
                              child: Center(
                                child: Text(
                                  wishCounterLogic.wishCount.value<99?'${wishCounterLogic.wishCount.value}':'···',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w900,
                                      fontFamily: 'Roboto',
                                      fontSize: 10, color: AppColors.white),
                                ),
                              ),
                            ))
                        : Container()
                  ],
                );
              }),
            ),
            Spacer(),
            Expanded(
                flex: 2,
                child: BottomNavigationItem(
                    onPress: () => onTap(Menus.them),
                    // icon: AppIcons.icThem,
                    current: currentIndex,
                    name: Menus.them)),
            Spacer(),
            Expanded(
              flex: 2,
              child: BottomNavigationItem(
                  onPress: () => onTap(Menus.user),
                  // icon: AppIcons.icUser,
                  current: currentIndex,
                  name: Menus.user),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
