import 'package:ask_ai/controllers/platform.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../utils/colors.dart';
import '../../utils/fonts.dart';

class BottomContainer extends StatelessWidget {
  BottomContainer({Key? key, required this.buttonText, required this.text, required this.func}) : super(key: key);
  final _platform = Get.find<PlatformController>();
  final String buttonText, text;
  final Function() func;
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.symmetric(
          horizontal: _platform.isTablet() ? 30.w : 20.w),
      child: Container(
        height: 55.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25.r),
              topRight: Radius.circular(25.r)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
             text,
              style: monserratMedium.copyWith(fontSize: _platform.isTablet() ? 13.sp : 14.sp),
            ),
            Padding(
              padding: EdgeInsets.only(left: 5.w),
              child: GestureDetector(
                  onTap: func,
                  child: Text(
                    buttonText,
                    style: monserratSemiBold.copyWith(
                        fontSize: _platform.isTablet() ? 13.sp : 14.sp, color: baseColor),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
