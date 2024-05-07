import 'package:ask_ai/controllers/onboarding.dart';
import 'package:ask_ai/controllers/platform.dart';
import 'package:ask_ai/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../utils/fonts.dart';
import '../../widgets/app_button.dart';

class MobileOnBoardingScreen extends StatelessWidget {
  MobileOnBoardingScreen({Key? key}) : super(key: key);
  final _platform = Get.find<PlatformController>();
  final _controller = Get.put(ObController());

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          body: Obx(() => Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: _platform.isTablet() ? 35.h : 30.h,
                      horizontal: _platform.isTablet() ? 35.w : 30.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding:
                            EdgeInsets.all(_platform.isTablet() ? 8.r : 5.r),
                        width: _platform.isTablet() ? 80.w : 90.w,
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: baseColor.withOpacity(0.25)),
                            borderRadius: BorderRadius.circular(10000),
                            color: baseColor.withOpacity(0.25)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            _ProgressDot(
                              func: () => _controller.index.value = 0,
                              size: _controller.index.value == 0
                                  ? _platform.isTablet()
                                      ? 9
                                      : 7
                                  : _platform.isTablet()
                                      ? 7
                                      : 6,
                              color: _controller.index.value == 0
                                  ? baseColor
                                  : baseColor.withOpacity(0.3),
                            ),
                            _ProgressDot(
                              func: () => _controller.index.value = 1,
                              size: _controller.index.value == 1
                                  ? _platform.isTablet()
                                      ? 9
                                      : 7
                                  : _platform.isTablet()
                                      ? 7
                                      : 6,
                              color: _controller.index.value == 1
                                  ? baseColor
                                  : baseColor.withOpacity(0.3),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 45.h),
                        child: LottieBuilder.asset(
                          _controller.animations[_controller.index.value],
                          height: _platform.isTablet() ? 230.h : 200.h,
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(bottom: 15.h),
                          child: Text(
                            _controller.title[_controller.index.value],
                            style: monserratSemiBold.copyWith(
                                fontSize: _platform.isTablet() ? 20.sp : 22.sp),
                            textAlign: TextAlign.center,
                          )),
                      Text(
                        _controller.subTitle[_controller.index.value],
                        style: monserratMedium.copyWith(
                            fontSize: _platform.isTablet() ? 14.sp : 17.sp,
                            color: black.withOpacity(0.5)),
                        textAlign: TextAlign.center,
                      ),
                      const Spacer(),
                      AppButton(
                          textColor: Colors.white,
                          onPressed: () => _controller.index.value == 0
                              ? _controller.goNext()
                              : _controller.skip(),
                          backgroundColor: baseColor,
                          height: _platform.isTablet() ? 55.h : 50.h,
                          fontSize: _platform.isTablet() ? 16.sp : 17.sp,
                          title:
                              _controller.index.value == 1 ? "Start" : "Next"),
                      SizedBox(
                        height: 10.h,
                      ),
                      TextButton(
                          onPressed: () => _controller.skip(),
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: baseColor,
                            fixedSize:
                                Size(MediaQuery.of(context).size.width, 50.h),
                          ),
                          child: Text(
                            "Skip",
                            style: monserratSemiBold.copyWith(
                              color: baseColor,
                              fontSize: _platform.isTablet() ? 16.sp : 17.sp,
                            ),
                          ))
                    ],
                  ),
                ),
              )),
        ),
      ),
    );
  }
}

class _ProgressDot extends StatelessWidget {
  const _ProgressDot(
      {Key? key, required this.size, required this.color, required this.func})
      : super(key: key);
  final double size;
  final Color color;
  final Function() func;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: func,
        child: CircleAvatar(
          backgroundColor: color,
          radius: size,
        ));
  }
}
