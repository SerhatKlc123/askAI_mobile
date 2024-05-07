import 'package:ask_ai/controllers/chat.dart';
import 'package:ask_ai/controllers/settings.dart';
import 'package:ask_ai/mobile_tablet/widgets/animations.dart';
import 'package:ask_ai/utils/colors.dart';
import 'package:ask_ai/utils/fonts.dart';
import 'package:ask_ai/web/widgets/new_chat_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SideBar extends StatelessWidget {
  SideBar({Key? key}) : super(key: key);
  final _chat = Get.find<ChatController>();
  final _setting = Get.put(SettingsController());
  final _padding = EdgeInsets.all(25.r);
  final _box = GetStorage();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: black,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // New Chat Button
          Padding(
              padding: _padding,
              child: NewChatButton(func: () => _chat.newWebChat())),

          Expanded(
              child: SingleChildScrollView(
            child: Obx(
              () => Scrollbar(
                thickness: 2.w,
                child: ListView.builder(
                    reverse: true,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (_, i) => Padding(
                          padding: EdgeInsets.symmetric(horizontal: 25.w),
                          child: ListTile(
                            onTap: () {
                              _chat.isFavorite.value =
                                  _chat.chats[i].favorite ?? false;
                              _chat.chatID = _chat.chats[i].id ?? "";
                              _chat.conversationName.value =
                                  _chat.chats[i].conversationName ?? "";
                              _chat.getWebMessages(_chat.chats[i].id ?? "");
                            },
                            minLeadingWidth: 0,
                            contentPadding: EdgeInsets.zero,
                            minVerticalPadding: 0,
                            trailing: Icon(
                              Icons.navigate_next,
                              color: Colors.white,
                              size: 25.r,
                            ),
                            title: Text(
                              _chat.chats[i].conversationName ?? "",
                              style: monserratSemiBold.copyWith(
                                  fontSize: 15.sp, color: Colors.white),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            subtitle: Text(
                              _chat.formatDate(_chat.chats[i].created ?? ""),
                              style: monserratMedium.copyWith(
                                  fontSize: 12.sp, color: Colors.grey.shade50),
                            ),
                          ),
                        ),
                    itemCount: _chat.chats.length),
              ),
            ),
          )),
          SizedBox(
            height: 30.h,
          ),
          Divider(
            color: Colors.white.withOpacity(0.5),
            thickness: 0.5.h,
            height: 19.h,
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
              child: _TabButton(
                  func: () {},
                  title: _box.read("email"),
                  iconData: Icons.alternate_email)),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: _TabButton(
                  func: () {
                    _chat.getFavorites();
                    showDialog(
                        builder: (ctx) => Dialog(
                              elevation: 1,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              backgroundColor: black,
                              insetPadding: EdgeInsets.symmetric(
                                  vertical:
                                      MediaQuery.of(context).size.height / 4,
                                  horizontal:
                                      MediaQuery.of(context).size.width / 4),
                              alignment: Alignment.center,
                              child: Obx(
                                () => _chat.favLoad.value
                                    ? const CenterLoad()
                                    : Column(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.all(30.r),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Favorite Chats",
                                                  style: monserratSemiBold
                                                      .copyWith(
                                                          color: Colors.white,
                                                          fontSize: 21.sp),
                                                ),
                                                GestureDetector(
                                                    onTap: () =>
                                                        Navigator.of(ctx).pop(),
                                                    child: Icon(
                                                      Icons.close,
                                                      color: Colors.white,
                                                      size: 28.r,
                                                    ))
                                              ],
                                            ),
                                          ),
                                          Container(
                                            color:
                                                Colors.white.withOpacity(0.5),
                                            height: 1.h,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(horizontal: 30.w,)  + EdgeInsets.only(top: 20.h),
                                            child: Row(
                                              children: [
                                              Text("Conversation Name", style: monserratMedium.copyWith(color: Colors.white, fontSize: 20.h),),
                                              const Spacer(),
                                              Text("Added At", style: monserratMedium.copyWith(color: Colors.white, fontSize: 20.h),),
                                                const Spacer(),
                                                SizedBox(width: 200.w,)

                                            ],),
                                          ),
                                          Expanded(
                                            child: SingleChildScrollView(
                                              child: Scrollbar(
                                                child: ListView.builder(
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  itemBuilder: (_, i) =>
                                                      GestureDetector(
                                                          child: Container(
                                                    padding:
                                                        EdgeInsets.symmetric(horizontal: 30.w),
                                                     child: Row(
                                                       children: [
                                                         Expanded(child: Text(_chat.favoriteChats[i].conversationName ?? "", style: monserratMedium.copyWith(color: Colors.white, fontSize: 19.sp), maxLines: 1,overflow: TextOverflow.ellipsis,)),
                                                         Expanded(child: Text(_chat.formatDate(_chat.favoriteChats[i].added ?? ""), style: monserratMedium.copyWith(color: Colors.white, fontSize: 19.sp), maxLines: 1,overflow: TextOverflow.ellipsis,)),
                                                         IconButton(onPressed: (){
                                                           Navigator.of(ctx).pop();
                                                          _chat.getWebMessages(_chat.favoriteChats[i].chatId ?? "");
                                                         },
                                                           icon: Icon(Icons.remove_red_eye_outlined, size: 25.r, color: Colors.white,),splashRadius: 25.r,
                                                         ),
                                                         IconButton(onPressed: (){
                                                           _chat.chatID = _chat.favoriteChats[i].chatId ?? "";
                                                           _chat.removeFavorite().then((value) => _chat.getFavorites().then((value) => _chat.getWebChats()));
                                                         },
                                                         icon: Icon(Icons.delete, size: 25.r, color: Colors.white,),splashRadius: 25.r,
                                                         ),
                                                       ],
                                                     ),
                                                  )),
                                                  itemCount: _chat
                                                      .favoriteChats.length,
                                                  shrinkWrap: true,
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                              ),
                            ),
                        context: context);
                  },
                  title: "Favorites",
                  iconData: Icons.favorite_border)),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: _TabButton(
                  func: () => _chat.deleteUserData(),
                  title: "Delete all records",
                  iconData: Icons.delete)),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h) +
                  EdgeInsets.only(bottom: 10.h),
              child: _TabButton(
                  func: () => _setting.webSignOut(),
                  title: "Sign Out",
                  iconData: Icons.logout)),
        ],
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  _TabButton(
      {Key? key,
      required this.func,
      required this.title,
      required this.iconData})
      : super(key: key);
  final Function() func;
  final String title;
  final IconData iconData;
  final _onHover = false.obs;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _onHover.value = true,
      onExit: (_) => _onHover.value = false,
      child: GestureDetector(
        onTap: () {
          _onHover.value = false;
          func();
        },
        child: Obx(
          () => Container(
            padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.r),
                color: _onHover.value ? Colors.grey.shade700 : black),
            child: Row(
              children: [
                Icon(
                  iconData,
                  color: Colors.white,
                  size: 27.r,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10.w),
                  child: Text(
                    title,
                    style: monserratMedium.copyWith(
                        fontSize: 16.sp, color: Colors.white),
                  ),
                ),
                const Spacer(),
                Icon(
                  Icons.navigate_next,
                  color: Colors.white,
                  size: 25.r,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
