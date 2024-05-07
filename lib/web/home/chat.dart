import 'package:ask_ai/controllers/chat.dart';
import 'package:ask_ai/mobile_tablet/widgets/animations.dart';
import 'package:ask_ai/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../utils/fonts.dart';
import '../widgets/messages.dart';

class WebChatPage extends StatelessWidget {
  WebChatPage({Key? key}) : super(key: key);
  final _chat = Get.find<ChatController>();
  final _textController = TextEditingController();
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width / 7.5,
              vertical: 30.h),
          child: Obx(
            () => _chat.loadScreen.value
                ? const CenterLoad()
                : Column(
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
                                  bottom: 30.h,
                                ),
                                child: const WebSystemMessage(
                                    answer:
                                        "Welcome to Ask AI chat experience! Get ready to explore the endless possibilities of conversation with our intelligent virtual assistant."),
                              ),
                              ListView.builder(
                                itemBuilder: (_, i) => Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    i % 2 == 0
                                        ? WebUserMessage(
                                            answer: _chat.chatMessages[i])
                                        : WebSystemMessage(
                                            answer: _chat.chatMessages[i]),
                                    SizedBox(
                                      height: 30.h,
                                    )
                                  ],
                                ),
                                itemCount: _chat.chatMessages.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                              ),
                              _chat.chatLoad.value
                                  ? WebSystemLoad()
                                  : const SizedBox()
                            ],
                          ),
                        ),
                      )),
                      Padding(
                        padding: EdgeInsets.only(top: 30.h),
                        child: !_chat.isEnable.value
                            ? Container(
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.all(30.h),
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: Colors.grey.shade100),
                                    color: Colors.grey.shade50,
                                    borderRadius: BorderRadius.circular(10.r)),
                                alignment: Alignment.center,
                                child: Text(
                                  "This is your preview chat",
                                  style: monserratSemiBold.copyWith(
                                      color: black.withOpacity(0.3),
                                      fontSize: 16.sp),
                                ),
                              )
                            : TextField(
                                cursorColor: Colors.grey.shade400,
                                style:
                                    monserratMedium.copyWith(fontSize: 16.sp),
                                controller: _textController,
                                onTap: () => _scroll(),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 20.w, vertical: 20.h),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.r),
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade200,
                                          width: 1.5.w)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.r),
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade200,
                                          width: 1.5.w)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.r),
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade200,
                                          width: 1.5.w)),
                                  disabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.r),
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade200,
                                          width: 1.5.w)),
                                  hintText: "Type your question here...",
                                  hintStyle: monserratMedium.copyWith(
                                      color: Colors.grey.shade400,
                                      fontSize: 16.sp),
                                  suffixIcon: GestureDetector(
                                      onTap: () {
                                        if (_textController.text.isNotEmpty &&
                                            !_chat.chatLoad.value) {
                                          if (_chat.chatID.isEmpty) {
                                            _chat.setChatLoad();
                                            _chat.chatMessages
                                                .add(_textController.text);
                                            _chat
                                                .createWebChat(
                                                    _textController.text)
                                                .then((value) =>
                                                    _chat.setChatLoad());
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
                                      child: Icon(Icons.send_outlined,
                                          color: Colors.grey.shade400,
                                          size: 30.r)),
                                )),
                      ),
                    ],
                  ),
          ),
        ),
        Obx(() =>
            _chat.conversationName.value.isNotEmpty && _chat.isEnable.value && !_chat.loadScreen.value
                ? Padding(
                    padding: EdgeInsets.only(right: 10.w, top: 10.h),
                    child: IconButton(
                      onPressed: () {
                        _chat.setWebLoad();
                        _chat.isFavorite.value
                            ? _chat
                                .removeFavorite()
                                .then((value) => _chat.getWebChats())
                                .then((value) => _chat.setWebLoad())
                            : _chat.addFavorite().then((value) => _chat
                                .getWebChats()
                                .then((value) => _chat.setWebLoad()));
                      },
                      icon: Icon(
                        _chat.isFavorite.value
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: Colors.red,
                        size: 30.r,
                      ),
                      splashRadius: 30.r,
                    ),
                  )
                : const SizedBox()),
      ],
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
