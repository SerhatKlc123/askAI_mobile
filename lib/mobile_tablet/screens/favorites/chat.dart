import 'package:ask_ai/controllers/chat.dart';
import 'package:ask_ai/controllers/platform.dart';
import 'package:ask_ai/mobile_tablet/widgets/animations.dart';
import 'package:ask_ai/mobile_tablet/widgets/message.dart';
import 'package:ask_ai/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../utils/fonts.dart';

class FavoriteChatScreen extends StatelessWidget {
  FavoriteChatScreen({Key? key}) : super(key: key);
  final _platform = Get.find<PlatformController>();
  final _chat = Get.find<ChatController>();
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: GestureDetector(
        onTap: () => Get.focusScope?.unfocus(),
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: _platform.isTablet() ? 55.h : null,
            elevation: 0.5,
            leading: Padding(
              padding: _platform.isTablet()
                  ? EdgeInsets.only(left: 10.w)
                  : EdgeInsets.zero,
              child: IconButton(
                onPressed: () => Get.back(),
                icon: Icon(
                  Icons.arrow_back_ios_new,
                  color: baseColor,
                  size: _platform.isTablet() ? 21.r : 22.r,
                ),
                splashRadius: 22.r,
              ),
            ),
            actions: [
              Padding(
                padding: _platform.isTablet()
                    ? EdgeInsets.only(right: 10.w)
                    : EdgeInsets.zero,
                child: IconButton(
                  onPressed: () => _chat.removeFavorite().then((value) {
                    _chat.getFavorites();
                    Get.toNamed("/mobile-favorite");
                  }),
                  icon: Icon(
                    Icons.delete_outline,
                    color: Colors.red,
                    size: 25.r,
                  ),
                  splashRadius: 22.r,
                ),
              )
            ],
            centerTitle: true,
            title: Text("Chat",
                style: monserratBold.copyWith(
                    fontSize: _platform.isTablet() ? 16.sp : 19.sp)),
          ),
          body: Obx(
            () => _chat.loadScreen.value
                ? const CenterLoad()
                : SingleChildScrollView(
                    controller: _scrollController,
                    child: Padding(
                      padding:
                          EdgeInsets.only(top: 15.r, left: 15.r, right: 15.r),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              bottom: _platform.isTablet() ? 20.h : 25.h,
                            ),
                            child: SystemMessage(
                                answer:
                                    "Welcome to Ask AI chat experience! Get ready to explore the endless possibilities of conversation with our intelligent virtual assistant."),
                          ),
                          ListView.builder(
                            reverse: true,
                            itemBuilder: (_, i) => Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                i % 2 == 0
                                    ? UserMessage(answer: _chat.chatMessages[i])
                                    : SystemMessage(
                                        answer: _chat.chatMessages[i]),
                                SizedBox(
                                  height: _platform.isTablet() ? 20.h : 25.h,
                                )
                              ],
                            ),
                            itemCount: _chat.chatMessages.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                          ),
                        ],
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
