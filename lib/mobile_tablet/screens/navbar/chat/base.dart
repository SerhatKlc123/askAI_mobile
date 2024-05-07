import 'package:ask_ai/controllers/platform.dart';
import 'package:ask_ai/mobile_tablet/widgets/animations.dart';
import 'package:ask_ai/utils/colors.dart';
import 'package:ask_ai/utils/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../controllers/chat.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({Key? key}) : super(key: key);
  final _platform = Get.find<PlatformController>();
  final _chat = Get.put(ChatController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Stack(
        alignment: Alignment.bottomRight,
        children: [
          _chat.load.value
              ? const CenterLoad()
              : _chat.chats.isEmpty
                  ? Empty()
                  : SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  top: _platform.isTablet() ? 12.h : 5.h),
                              child: ListView.separated(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: _chat.chats.length,
                                separatorBuilder: (_, i) => Divider(
                                  color: Colors.grey.shade200,
                                  thickness: 1.w,
                                ),
                                itemBuilder: (_, i) => Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical:
                                          _platform.isTablet() ? 12.h : 0),
                                  child: ListTile(
                                    onTap: () {
                                      _chat.chatID = _chat.chats[i].id ?? "";
                                      _chat.conversationName.value =
                                          _chat.chats[i].conversationName ?? "";
                                      _chat.isFavorite.value =
                                          _chat.chats[i].favorite ?? false;
                                      _chat.getMessages(_chat.chats[i].id ?? "",
                                          "/mobile-chat");
                                    },
                                    leading: CircleAvatar(
                                      radius:
                                          _platform.isTablet() ? 22.r : 20.r,
                                      backgroundColor:
                                          baseColor.withOpacity(0.1),
                                      child: Icon(
                                        Icons.chat_outlined,
                                        color: baseColor,
                                        size: 18.r,
                                      ),
                                    ),
                                    trailing: Icon(
                                      Icons.navigate_next,
                                      color: Colors.grey.shade200,
                                      size: _platform.isTablet() ? 28.r : 25.r,
                                    ),
                                    title: Text(
                                        _chat.chats[i].conversationName ??
                                            "Conversation",
                                        style: monserratSemiBold.copyWith(
                                            fontSize: _platform.isTablet()
                                                ? 12.sp
                                                : 14.sp),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis),
                                    subtitle: Padding(
                                      padding: _platform.isTablet()
                                          ? EdgeInsets.only(top: 5.h)
                                          : EdgeInsets.zero,
                                      child: Text(
                                          _chat.formatDate(
                                            _chat.chats[i].created ??
                                                "2024-05-05T21:43:16.987+00:00",
                                          ),
                                          style: monserratMedium.copyWith(
                                              color: black.withOpacity(0.5),
                                              fontSize: _platform.isTablet()
                                                  ? 11.sp
                                                  : 12.sp),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Divider(
                              color: Colors.grey.shade200,
                              thickness: 1.w,
                            ),
                          ],
                        ),
                      ),
                    ),
          _chat.load.value
              ? const SizedBox()
              : Padding(
                  padding: EdgeInsets.all(_platform.isTablet() ? 12.r : 15.r),
                  child: GestureDetector(
                    onTap: () {
                      // Remove previous data if exist then navigate
                      _chat.conversationName.value = "";
                      _chat.chatID = "";
                      _chat.chatMessages.clear();
                      Get.toNamed("/mobile-chat");
                    },
                    child: Container(
                      width: _platform.isTablet() ? 115.w : 140.w,
                      padding: EdgeInsets.all(15.r),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [baseColor, baseColor.withOpacity(0.5)],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade100,
                            spreadRadius: 3,
                            blurRadius: 5,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add,
                            color: Colors.white,
                            size: _platform.isTablet() ? 22.r : 20.r,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 5.w),
                            child: Text(
                              "New Chat",
                              style: monserratSemiBold.copyWith(
                                  color: Colors.white,
                                  fontSize:
                                      _platform.isTablet() ? 13.sp : 15.sp),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
        ],
      ),
    );
  }
}
