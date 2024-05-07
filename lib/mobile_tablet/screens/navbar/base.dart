import 'package:ask_ai/controllers/chat.dart';
import 'package:ask_ai/controllers/navbar.dart';
import 'package:ask_ai/controllers/platform.dart';
import 'package:ask_ai/mobile_tablet/widgets/bottom_navbar.dart';
import 'package:ask_ai/utils/colors.dart';
import 'package:ask_ai/utils/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class NavbarBase extends StatelessWidget {
  NavbarBase({Key? key}) : super(key: key);
  final _controller = Get.put(NavbarController());
  final _chat = Get.find<ChatController>();
  final _platform = Get.find<PlatformController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey.shade50,
          leadingWidth: 0,
          toolbarHeight: _platform.isTablet() ? 55.h : null,
          centerTitle: false,
          title: Text(
            _controller.index.value == 0 ? "Chats" : "Settings",
            style: monserratBold.copyWith(
                fontSize: _platform.isTablet() ? 16.sp : 19.sp),
          ),
          actions: _controller.index.value == 1
              ? null
              : [
                  Padding(
                    padding: EdgeInsets.only(right: 8.w),
                    child: TextButton(
                        onPressed: () {
                          Get.toNamed("/mobile-favorite");
                          _chat.getFavorites();
                        },
                        child: Text(
                          "Favorites",
                          style: monserratMedium.copyWith(
                              fontSize: _platform.isTablet() ? 13.sp : 16.sp,
                              color: purple),
                        )),
                  )
                ],
        ),
        backgroundColor:
            _controller.index.value == 1 ? Colors.grey.shade50 : Colors.white,
        body: Column(
          children: [
            // Set page with controller
            Expanded(
                child: Obx(() => _controller.screens[_controller.index.value])),
            BottomNavbar()
          ],
        ),
      ),
    );
  }
}
