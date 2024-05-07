import 'package:ask_ai/controllers/platform.dart';
import 'package:ask_ai/mobile_tablet/widgets/animations.dart';
import 'package:ask_ai/utils/colors.dart';
import 'package:ask_ai/utils/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../controllers/chat.dart';

class FavoriteScreen extends StatelessWidget {
  FavoriteScreen({Key? key}) : super(key: key);
  final _platform = Get.find<PlatformController>();
  final _chat = Get.put(ChatController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: _platform.isTablet() ? 55.h : null,
          elevation: 0.5,
          leading: Padding(
            padding: _platform.isTablet()
                ? EdgeInsets.only(left: 10.w)
                : EdgeInsets.zero,
            child: IconButton(
              onPressed: () => Get.offAndToNamed("/mobile-home"),
              icon: Icon(
                Icons.arrow_back_ios_new,
                color: baseColor,
                size: _platform.isTablet() ? 21.r : 22.r,
              ),
              splashRadius: 22.r,
            ),
          ),
          centerTitle: true,
          title: Text("Favorites",
              style: monserratBold.copyWith(
                  fontSize: _platform.isTablet() ? 16.sp : 19.sp)),
        ),
        body: Obx(
          () => _chat.favLoad.value
              ? const CenterLoad()
              : _chat.favoriteChats.isEmpty
                  ? Empty()
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                top: _platform.isTablet() ? 12.h : 5.h),
                            child: ListView.separated(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: _chat.favoriteChats.length,
                              separatorBuilder: (_, i) => Divider(
                                color: Colors.grey.shade200,
                                thickness: 1.w,
                              ),
                              itemBuilder: (_, i) => Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: _platform.isTablet() ? 12.h : 0),
                                child: ListTile(
                                  onTap: () {
                                    _chat.chatID =
                                        _chat.favoriteChats[i].chatId ?? "";
                                    _chat.conversationName.value = _chat
                                            .favoriteChats[i]
                                            .conversationName ??
                                        "";
                                    _chat.isFavorite.value = true;
                                    _chat.getMessages(
                                        _chat.favoriteChats[i].chatId ?? "",
                                        "/mobile-favorite-preview");
                                  },
                                  leading: CircleAvatar(
                                    radius: _platform.isTablet() ? 22.r : 20.r,
                                    backgroundColor: purple.withOpacity(0.1),
                                    child: Icon(
                                      Icons.favorite,
                                      color: purple,
                                      size: 18.r,
                                    ),
                                  ),
                                  trailing: Icon(
                                    Icons.navigate_next,
                                    color: Colors.grey.shade200,
                                    size: _platform.isTablet() ? 28.r : 25.r,
                                  ),
                                  title: Text(
                                      _chat.favoriteChats[i].conversationName ??
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
                                          _chat.favoriteChats[i].added ??
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
      ),
    );
  }
}
