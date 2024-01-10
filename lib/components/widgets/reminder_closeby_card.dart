import 'dart:async';
import 'dart:math';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:wowowwish/model/reminder_simple.dart';
import 'package:wowowwish/styles/app_colors.dart';

class ReminderCloseByCard extends StatefulWidget {
  const ReminderCloseByCard({
    Key? key,
    required this.simpleReminderList,
  }) : super(key: key);
  final List<SimpleReminder> simpleReminderList;
  @override
  _ReminderCloseByCardState createState() => _ReminderCloseByCardState();
}

class _ReminderCloseByCardState extends State<ReminderCloseByCard>
    with TickerProviderStateMixin {

  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: false);
  }

  gapTransTo(int gap) {
    return gap == 0
        ? '今天'
        : gap == 1
            ? '明天'
            : '$gap 天后';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 50,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.reminderCloseByColor,
        borderRadius: BorderRadius.circular(34),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowColor,
            blurRadius: 6,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Row(
        children: [
          Spacer(),
          Expanded(
            flex: 12,
            child: SizedBox(
              width: 250.0,
              child: DefaultTextStyle(
                  style: const TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w900,
                  ),
                  child: AnimatedTextKit(
                      pause: const Duration(milliseconds: 1000),
                      animatedTexts: [
                        TypewriterAnimatedText(
                            ''),
                        for (SimpleReminder item in widget.simpleReminderList)
                          TypewriterAnimatedText(
                              '${gapTransTo(item.gap)}是 ${item.description}')
                      ])
                  ),
            ),
          ),
          const Spacer(),
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AnimatedBuilder(
                  animation: _animationController,
                  builder: (_, __) {
                    return Transform.translate(
                      offset: Offset(0, sin(_animationController.value * 2 * pi) * 2),
                      child: const CircleAvatar(
                        radius: 4,
                        backgroundColor: AppColors.reminderCloseByBallColor,
                      ),
                    );
                  },
                ),
                SizedBox(width: 8),
                AnimatedBuilder(
                  animation: _animationController,
                  builder: (_, __) {
                    return Transform.translate(
                      offset: Offset(0, sin((_animationController.value - 0.2) * 2 * pi) * 2),
                      child: const CircleAvatar(
                        radius: 4,
                        backgroundColor: AppColors.reminderCloseByBallColor,
                      ),
                    );
                  },
                ),
                SizedBox(width: 8),
                AnimatedBuilder(
                  animation: _animationController,
                  builder: (_, __) {
                    return Transform.translate(
                      offset: Offset(0, sin((_animationController.value - 0.4) * 2 * pi) * 2),
                      child: const CircleAvatar(
                        radius: 4,
                        backgroundColor: AppColors.reminderCloseByBallColor,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            width: 25,
          )
        ],
      ),
    );
    //   ScaleTransition(
    //   scale: _scaleAnimation2,
    //   child: Container(
    //     width: 350,
    //     height: 42,
    //     clipBehavior: Clip.antiAlias,
    //     decoration: BoxDecoration(
    //       color: Color(0xFF232323),
    //       borderRadius: BorderRadius.circular(34),
    //       boxShadow: [
    //         BoxShadow(
    //           color: Colors.black.withOpacity(0.25),
    //           blurRadius: 6,
    //           offset: const Offset(0, 4),
    //         )
    //       ],
    //     ),
    //     child: Row(
    //       children: [
    //         Spacer(),
    //         Expanded(
    //           flex: 3,
    //           child: Text(
    //             '${widget.gap} 天后是 ${widget.reminderText}',
    //             textAlign: TextAlign.center,
    //             style: const TextStyle(
    //               color: Colors.white,
    //               fontSize: 12,
    //               overflow: TextOverflow.ellipsis,
    //               fontWeight: FontWeight.w600,
    //             ),
    //           ),
    //         ),
    //         const Spacer(),
    //
    //         Expanded(
    //           child: Row(
    //             children: [
    //               ScaleTransition(
    //                 scale: _scaleAnimation,
    //                 child: const CircleAvatar(
    //                   radius: 7,
    //                   backgroundColor: Color(0xFFBDF324),
    //                 ),
    //               ),
    //               const SizedBox(width: 5,),
    //               ScaleTransition(
    //                 scale: _scaleAnimation,
    //                 child: const CircleAvatar(
    //                   radius: 5,
    //                   backgroundColor: Color(0xFFBDF324),
    //                 ),
    //               ),
    //               const SizedBox(width: 5,),
    //               ScaleTransition(
    //                 scale: _scaleAnimation,
    //                 child: const CircleAvatar(
    //                   radius: 3,
    //                   backgroundColor: Color(0xFFBDF324),
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //         SizedBox(width: 25,)
    //       ],
    //     ),
    //   ),
    // );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
