import 'package:ask_ai/controllers/platform.dart';
import 'package:ask_ai/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../utils/fonts.dart';

final _platform = Get.find<PlatformController>();

void successBar(String message) => Get.snackbar(
      '',
      '',
      margin: _platform.isTablet()
          ? EdgeInsets.all(18.r)
          : EdgeInsets.all(15.r) +
              EdgeInsets.only(
                  left: _platform.platformType == PlatformType.web
                      ? Get.context!.size!.width / 1.5
                      : 0.w),
      padding: _platform.isTablet()
          ? EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h)
          : null,
      icon: Icon(
        Icons.celebration,
        color: baseColor,
        size: 28.r,
      ),
      borderRadius: 15.r,
      borderColor: baseColor.withOpacity(0.05),
      borderWidth: 1.5.w,
      shouldIconPulse: true,
      titleText: Text("Success!",
          style:
              monserratSemiBold.copyWith(fontSize: 14.sp, color: Colors.white)),
      messageText: Text(message,
          style:
              monserratMedium.copyWith(fontSize: 13.sp, color: Colors.white)),
      backgroundColor: baseColor.withOpacity(0.30),
    );

void errorBar(String message) => Get.snackbar(
      '',
      '',
      margin: _platform.isTablet()
          ? EdgeInsets.all(18.r)
          : EdgeInsets.all(15.r) +
              EdgeInsets.only(
                  left: _platform.platformType == PlatformType.web
                      ? Get.context!.size!.width / 1.5
                      : 0.w),
      padding: _platform.isTablet()
          ? EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h)
          : null,
      icon: Icon(
        Icons.announcement,
        color: errorColor,
        size: 28.r,
      ),
      borderRadius: 15.r,
      borderColor: errorColor.withOpacity(0.05),
      borderWidth: 1.5.w,
      shouldIconPulse: true,
      titleText: Text("Oops!",
          style:
              monserratSemiBold.copyWith(fontSize: 14.sp, color: Colors.white)),
      messageText: Text(message,
          style:
              monserratMedium.copyWith(fontSize: 13.sp, color: Colors.white)),
      backgroundColor: errorColor.withOpacity(0.30),
    );
