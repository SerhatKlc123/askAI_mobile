import 'dart:async';

import 'package:ask_ai/controllers/onboarding.dart';
import 'package:ask_ai/utils/colors.dart';
import 'package:ask_ai/utils/fonts.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class WebOnBoarding extends StatefulWidget {
  WebOnBoarding({Key? key}) : super(key: key);

  @override
  State<WebOnBoarding> createState() => _WebOnBoardingState();
}

class _WebOnBoardingState extends State<WebOnBoarding> {
  final _controller = Get.put(ObController());
  // Set a timer for auto scrolling
  Timer? _timer;
  final _load = false.obs;

  void _setScrollEvent() {
    // Change widget every 4 second
    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      _load.value = true;
      _controller.setIndexForWeb();
      Future.delayed(
          const Duration(milliseconds: 100), () => _load.value = false);
    });
  }

  @override
  void initState() {
    _setScrollEvent();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: baseColor,
      child: Obx(
        () => Padding(
          padding: EdgeInsets.all(50.r),
          child: _load.value
              ? const SizedBox()
              : DelayedDisplay(
                  delay: const Duration(milliseconds: 200),
                  slidingCurve: Curves.easeOut,
                  fadeIn: true,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      LottieBuilder.asset(
                        "assets/animations/ob${_controller.index.value}.json",
                        height: MediaQuery.of(context).size.height / 2.5,
                      ),
                      Padding(
                          padding: EdgeInsets.only(top: 40.h, bottom: 8.h),
                          child: Text(
                            _controller.title[_controller.index.value],
                            style: monserratSemiBold.copyWith(
                                fontSize: 22.sp, color: Colors.white),
                          )),
                      Text(
                        _controller.subTitle[_controller.index.value],
                        style: monserratMedium.copyWith(
                            fontSize: 18.sp,
                            color: Colors.grey.shade50,
                            height: 1.5),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
