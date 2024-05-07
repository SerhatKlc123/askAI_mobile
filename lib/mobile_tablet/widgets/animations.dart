import 'package:ask_ai/controllers/platform.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class Load extends StatelessWidget {
  const Load({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      heightFactor: 0.3,
      child: SizedBox(
          height: 100.h,
          child: LottieBuilder.asset('assets/animations/circular_load.json')),
    );
  }
}

class CenterLoad extends StatelessWidget {
  const CenterLoad({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LottieBuilder.asset('assets/animations/circular_load.json', height: 120.h,),
    );
  }
}

class Empty extends StatelessWidget {
   Empty({Key? key}) : super(key: key);
  final _platform = Get.find<PlatformController>();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Transform.scale(
        scale: _platform.isTablet() ? 1.5 : 1.1,
        child: LottieBuilder.asset('assets/animations/empty.json'),
      ),
    );
  }
}

