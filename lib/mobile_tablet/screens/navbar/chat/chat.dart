import 'package:ask_ai/controllers/chat.dart';
import 'package:ask_ai/controllers/platform.dart';
import 'package:ask_ai/mobile_tablet/widgets/animations.dart';
import 'package:ask_ai/mobile_tablet/widgets/message.dart';
import 'package:ask_ai/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../utils/fonts.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({Key? key}) : super(key: key);
  final _platform = Get.find<PlatformController>();
  final _chat = Get.find<ChatController>();
  final _textController = TextEditingController();
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
                onPressed: () => _chat.chatLoad.value ? null : Get.back(),
                icon: Icon(
                  Icons.arrow_back_ios_new,
                  color: baseColor,
                  size: _platform.isTablet() ? 21.r : 22.r,
                ),
                splashRadius: 22.r,
              ),
            ),
            actions: [
              Obx(() => _chat.conversationName.value.isNotEmpty
                  ? Padding(
                      padding: _platform.isTablet()
                          ? EdgeInsets.only(right: 10.w)
                          : EdgeInsets.zero,
                      child: IconButton(
                        onPressed: () => _chat.isFavorite.value
                            ? _chat
                                .removeFavorite()
                                .then((value) => _chat.getChats())
                            : _chat
                                .addFavorite()
                                .then((value) => _chat.getChats()),
                        icon: Icon(
                          _chat.isFavorite.value
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: Colors.red,
                          size: 25.r,
                        ),
                        splashRadius: 22.r,
                      ),
                    )
                  : const SizedBox()),
            ],
            centerTitle: true,
            title: Text("Chat",
                style: monserratBold.copyWith(
                    fontSize: _platform.isTablet() ? 16.sp : 19.sp)),
          ),
          body: Obx(
            () => _chat.loadScreen.value
                ? const CenterLoad()
                : Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          child: SingleChildScrollView(
                        controller: _scrollController,
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: 15.r, left: 15.r, right: 15.r),
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
                                        ? UserMessage(
                                            answer: _chat.chatMessages[i])
                                        : SystemMessage(
                                            answer: _chat.chatMessages[i]),
                                    SizedBox(
                                      height:
                                          _platform.isTablet() ? 20.h : 25.h,
                                    )
                                  ],
                                ),
                                itemCount: _chat.chatMessages.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                              ),
                              _chat.chatLoad.value
                                  ? SystemLoad()
                                  : const SizedBox()
                            ],
                          ),
                        ),
                      )),
                      Padding(
                        padding: EdgeInsets.all(15.r),
                        child: TextField(
                            cursorColor: Colors.grey.shade400,
                            style: monserratMedium.copyWith(
                                fontSize: _platform.isTablet() ? 12.sp : 14.sp),
                            controller: _textController,
                            onTap: () => _scroll(),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10.w, vertical: 15.h),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      _platform.isTablet() ? 10.r : 15.r),
                                  borderSide: BorderSide(
                                      color: Colors.grey.shade200,
                                      width: 1.5.w)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      _platform.isTablet() ? 10.r : 15.r),
                                  borderSide: BorderSide(
                                      color: Colors.grey.shade200,
                                      width: 1.5.w)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      _platform.isTablet() ? 10.r : 15.r),
                                  borderSide: BorderSide(
                                      color: Colors.grey.shade200,
                                      width: 1.5.w)),
                              disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      _platform.isTablet() ? 10.r : 15.r),
                                  borderSide: BorderSide(
                                      color: Colors.grey.shade200,
                                      width: 1.5.w)),
                              hintText: "Type your question here...",
                              hintStyle: monserratMedium.copyWith(
                                  color: Colors.grey.shade400,
                                  fontSize:
                                      _platform.isTablet() ? 12.sp : 14.sp),
                              suffixIcon: GestureDetector(
                                  onTap: () {
                                    if (_textController.text.isNotEmpty && !_chat.chatLoad.value) {
                                      if (_chat.chatID.isEmpty) {

                                        _chat.chatMessages
                                            .add(_textController.text);
                                        _chat
                                            .createChat(_textController.text);
                                        Get.focusScope?.unfocus();
                                        _textController.clear();
                                      } else {
                                        _chat.setChatLoad();
                                        _scroll();
                                        _chat.chatMessages
                                            .add(_textController.text);
                                        _chat
                                            .askToAi(_textController.text)
                                            .then((value) {
                                          _chat.setChatLoad();
                                          _scroll();
                                        });
                                        Get.focusScope?.unfocus();
                                        _textController.clear();
                                      }
                                    }
                                  },
                                  child: Padding(
                                    padding: _platform.isTablet()
                                        ? EdgeInsets.only(right: 10.w)
                                        : EdgeInsets.zero,
                                    child: Icon(
                                      Icons.send_outlined,
                                      color: Colors.grey.shade400,
                                      size: _platform.isTablet() ? 20.r : 20.r,
                                    ),
                                  )),
                            )),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  void _scroll() => Future.delayed(const Duration(milliseconds: 500), () {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
}
