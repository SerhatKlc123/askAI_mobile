import 'package:ask_ai/controllers/platform.dart';
import 'package:ask_ai/utils/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../utils/colors.dart';

class WebSystemMessage extends StatelessWidget {
  const WebSystemMessage({Key? key, required this.answer}) : super(key: key);
  final String answer;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
              radius: 30.r,
              backgroundColor: black,
              child: LottieBuilder.asset(
                "assets/animations/ob1.json",
                height: 30.h,
              )),
          Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 15.w),
                child: Container(
                  padding: EdgeInsets.all(18.r),
                  decoration: BoxDecoration(
                      color: baseColor.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(10.r)),
                  child: Text(
                    answer,
                    style: monserratMedium.copyWith(fontSize: 17.sp, height: 2.h),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}

class WebUserMessage extends StatelessWidget {
  const WebUserMessage({Key? key, required this.answer}) : super(key: key);
  final String answer;

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
                  padding: EdgeInsets.all(18.r),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(10.r)),
                  child: Text(
                    answer,
                    style: monserratMedium.copyWith(fontSize: 17.sp, height: 2.h),)
                ),
              )),
          CircleAvatar(
              radius: 30.r,
              backgroundColor: purple.withOpacity(0.15),
              child: Icon(
                Icons.person_outline,
                color: purple,
                size: 30.r,
              )),
        ],
      ),
    );
  }
}


class WebSystemLoad extends StatelessWidget {
  const WebSystemLoad({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
              radius: 25.r,
              backgroundColor: black,
              child: LottieBuilder.asset(
                "assets/animations/ob1.json",
                height: 25.h,
              )),
          Padding(
            padding: EdgeInsets.only(left: 10.w),
            child: Container(
                width: 47.w,
                decoration: BoxDecoration(
                    color: baseColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(10.r)),
                child: LottieBuilder.asset("assets/animations/circular_load.json", height:50.h,)
            ),
          )
        ],
      ),
    );
  }
}
