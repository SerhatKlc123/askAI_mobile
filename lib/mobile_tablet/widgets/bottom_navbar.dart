import 'package:ask_ai/controllers/navbar.dart';
import 'package:ask_ai/controllers/platform.dart';
import 'package:ask_ai/utils/colors.dart';
import 'package:ask_ai/utils/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BottomNavbar extends StatelessWidget {
  BottomNavbar({Key? key}) : super(key: key);
  final _platform = Get.find<PlatformController>();
  // I created a custom bottom navigation bar which has 2 page
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.r),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: grey.withOpacity(0.1),
              spreadRadius: 0.5,
              blurRadius: 3,
              offset: const Offset(
                  0, -1), // Negative offset to apply shadow only at the top
            ),
          ],
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(_platform.isTablet() ? 35.r : 25.r),
              topLeft: Radius.circular(_platform.isTablet() ? 35.r : 25.r))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _NavbarItem(
            icon: Icons.chat_bubble_outline,
            text: "Chats",
            index: 0,
          ),
          _NavbarItem(
            icon: Icons.settings,
            text: "Settings",
            index: 1,
          ),
        ],
      ),
    );
  }
}

// Create a component for Navbar Items
class _NavbarItem extends StatelessWidget {
  _NavbarItem(
      {Key? key, required this.text, required this.icon, required this.index})
      : super(key: key);
  final String text;
  final IconData icon;
  final int index;
  final _controller = Get.find<NavbarController>();
  final _platform = Get.find<PlatformController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GestureDetector(
        onTap: () => _controller.setIndex(index),
        child: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: _controller.index.value == index
                    ? purple
                    : grey.withOpacity(0.5),
                size: 28.r,
              ),
              _controller.index.value != index
                  ? const SizedBox()
                  : Padding(
                      padding: EdgeInsets.only(top: 5.h),
                      child: Text(
                        text,
                        style: monserratSemiBold.copyWith(
                          color: _controller.index.value == index
                              ? purple
                              : grey.withOpacity(0.5),
                          fontSize: _platform.isTablet() ? 12.sp : 14.sp,
                        ),
                      ))
            ],
          ),
        ),
      ),
    );
  }
}
