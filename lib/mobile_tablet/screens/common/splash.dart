import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:ask_ai/mobile_tablet/screens/auth/register.dart';
import 'package:ask_ai/mobile_tablet/screens/navbar/base.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../controllers/platform.dart';
import 'onboarding.dart';

class MobileSplashScreen extends StatelessWidget {
  MobileSplashScreen({Key? key}) : super(key: key);
  final _platform = Get.find<PlatformController>();
  final _box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      // Define a custom design size for mobile and tablet
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) => Scaffold(
        body: Center(
          child:  AnimatedSplashScreen(
              splash: 'assets/images/logo.png',
              duration: 2000,
              centered: true,
              splashIconSize: _platform.isTablet() ? 200.r : 150.r,
              nextScreen: _box.read("page") == 1 ? MobileRegisterScreen() : _box.read("page") == 2 ? NavbarBase() : MobileOnBoardingScreen(),
              splashTransition: SplashTransition.fadeTransition,
            ),
          ),
        ),

    );
  }
}
