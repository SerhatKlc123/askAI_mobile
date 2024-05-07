import 'package:ask_ai/controllers/platform.dart';
import 'package:ask_ai/utils/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../utils/colors.dart';

class SystemMessage extends StatelessWidget {
   SystemMessage({Key? key, required this.answer}) : super(key: key);
  final String answer;
  final _platform = Get.find<PlatformController>();


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
              radius: 20.r,
              backgroundColor: black,
              child: LottieBuilder.asset(
                "assets/animations/ob1.json",
                height: 25.h,
              )),
          Expanded(
              child: Padding(
            padding: EdgeInsets.only(left: 10.w),
            child: Container(
              padding: EdgeInsets.all(14.r),
              decoration: BoxDecoration(
                  color: baseColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(10.r)),
              child: Text(
                answer,
                style: monserratMedium.copyWith(fontSize: _platform.isTablet() ? 11.sp : 14.sp, height:_platform.isTablet() ? 1.1.h : 1.3.h),
              ),
            ),
          ))
        ],
      ),
    );
  }
}

class UserMessage extends StatelessWidget {
  UserMessage({Key? key, required this.answer}) : super(key: key);
  final String answer;
  final _platform = Get.find<PlatformController>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: Padding(
            padding: EdgeInsets.only(right: 10.w),
            child: Container(
              padding: EdgeInsets.all(14.r),
              decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(10.r)),
              child: Text(
                answer,
                style: monserratMedium.copyWith(fontSize: _platform.isTablet() ? 11.sp : 14.sp, height:_platform.isTablet() ? 1.1.h : 1.3.h),
              ),
            ),
          )),
          CircleAvatar(
              radius: 20.r,
              backgroundColor: purple.withOpacity(0.15),
              child: Icon(
                Icons.person_outline,
                color: purple,
                size: 25.r,
              )),
        ],
      ),
    );
  }
}


class SystemLoad extends StatelessWidget {
   SystemLoad({Key? key}) : super(key: key);
  final _platform = Get.find<PlatformController>();


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
              radius: 20.r,
              backgroundColor: black,
              child: LottieBuilder.asset(
                "assets/animations/ob1.json",
                height: 25.h,
              )),
          Padding(
            padding: EdgeInsets.only(left: 10.w),
            child: Container(
              width: _platform.isTablet() ? 35.w : 45.w,
              decoration: BoxDecoration(
                  color: baseColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(10.r)),
              child: LottieBuilder.asset("assets/animations/circular_load.json", height: 45.h,)
            ),
          )
        ],
      ),
    );
  }
}
