import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:ask_ai/web/home/base.dart';
import 'package:ask_ai/web/screens/auth/base.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';

class WebSplashScreen extends StatelessWidget {
  WebSplashScreen({Key? key}) : super(key: key);
  final _box = GetStorage();
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      // Define a custom design size for web
      designSize: const Size(1920, 1080),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) => Scaffold(
        body: Center(
          child: AnimatedSplashScreen(
            splash: 'assets/images/logo.png',
            duration: 2000,
            centered: true,
            splashIconSize: 200.r,
            nextScreen: _box.read("web-page") == 1 ? WebHome() : WebAuthBase()
          )
        ),
      ),
    );
  }
}
