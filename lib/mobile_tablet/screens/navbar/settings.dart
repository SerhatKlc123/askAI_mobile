import 'package:ask_ai/controllers/chat.dart';
import 'package:ask_ai/controllers/platform.dart';
import 'package:ask_ai/controllers/settings.dart';
import 'package:ask_ai/utils/colors.dart';
import 'package:ask_ai/utils/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({Key? key}) : super(key: key);
  final _settings = Get.put(SettingsController());
  final _chat = Get.find<ChatController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _SettingContainer(
            title: _settings.getMail(),
            icon: Icons.alternate_email,
            color: purple),
        _SettingContainer(
          title: 'Remove All User Data',
          icon: Icons.delete_outline,
          color: errorColor,
          function: () => _chat.deleteUserData(),
        ),
        _SettingContainer(
          title: 'Sign Out',
          icon: Icons.logout,
          color: Colors.deepOrange,
          function: () => _settings.signOut(),
        ),
      ],
    );
  }
}

class _SettingContainer extends StatelessWidget {
  _SettingContainer(
      {Key? key,
      required this.title,
      required this.icon,
      this.function,
      required this.color})
      : super(key: key);
  final String title;
  final IconData icon;
  final Color color;
  final Function()? function;
  final _platform = Get.find<PlatformController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w) +
          EdgeInsets.only(bottom: 12.h),
      child: Material(
        color: Colors.white,
        elevation: 0.2,
        borderRadius: BorderRadius.circular(10.r),
        child: InkWell(
          onTap: function,
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(_platform.isTablet() ? 22.r : 20.r),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: color,
                  size: _platform.isTablet() ? 23.r : 20.r,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10.w),
                  child: Text(
                    title,
                    style: monserratMedium.copyWith(
                        fontSize: _platform.isTablet() ? 12.5.sp : 15.sp),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Spacer(),
                Icon(
                  Icons.navigate_next,
                  color: color,
                  size: _platform.isTablet() ? 28.r : 25.r,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
