import 'package:ask_ai/controllers/auth.dart';
import 'package:ask_ai/controllers/platform.dart';
import 'package:ask_ai/mobile_tablet/widgets/app_button.dart';
import 'package:ask_ai/mobile_tablet/widgets/auth_curved.dart';
import 'package:ask_ai/mobile_tablet/widgets/auth_field.dart';
import 'package:ask_ai/mobile_tablet/widgets/curved_container.dart';
import 'package:ask_ai/mobile_tablet/widgets/animations.dart';
import 'package:ask_ai/mobile_tablet/widgets/sheet.dart';
import 'package:ask_ai/mobile_tablet/widgets/snack.dart';
import 'package:ask_ai/utils/colors.dart';
import 'package:ask_ai/utils/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MobileLoginScreen extends StatelessWidget {
  MobileLoginScreen({Key? key}) : super(key: key);
  final _auth = Get.find<AuthController>();
  final _platform = Get.find<PlatformController>();
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: GestureDetector(
        onTap: () => Get.focusScope?.unfocus(),
        child: Container(
          color: lightGrey,
          child: Scaffold(
              backgroundColor: lightGrey,
              body: SingleChildScrollView(
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    AuthCurvedDisplay(
                      children: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: _platform.isTablet() ? 30.h : 20.h,
                            horizontal: _platform.isTablet() ? 30.w : 20.w),
                        child: SafeArea(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Sign In",
                                style: monserratSemiBold.copyWith(
                                    fontSize:
                                        _platform.isTablet() ? 19.sp : 20.sp),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 5.h),
                                child: Text(
                                  "Welcome back to the app",
                                  style: monserratMedium.copyWith(
                                      fontSize:
                                          _platform.isTablet() ? 15.sp : 16.sp,
                                      color: black.withOpacity(0.75)),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 30.h),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.symmetric(
                                      vertical:
                                          _platform.isTablet() ? 25.h : 20.h,
                                      horizontal:
                                          _platform.isTablet() ? 25.w : 20.w),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.circular(25.r)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        "assets/images/logo.png",
                                        height: 100.h,
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(
                                              bottom: 20.h, top: 30.h),
                                          child: AuthField(
                                              controller: _email,
                                              icon: Icons.email_outlined,
                                              hintText: 'Email')),
                                      AuthField(
                                        controller: _password,
                                        icon: Icons.lock_outline,
                                        hintText: 'Password',
                                        isObscure: true,
                                      ),
                                      Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 20.h),
                                          child: Obx(
                                            () => _auth.load.value
                                                ? const Load()
                                                : AppButton(
                                                    onPressed: () {
                                                      if (_email.text.isEmpty ||
                                                          _password
                                                              .text.isEmpty) {
                                                        errorBar(
                                                            "Fill the fields before login.");
                                                      } else {
                                                        _auth
                                                            .login(
                                                                _email.text,
                                                                _password.text,
                                                                "/mobile-verify")
                                                            .then((value) {
                                                          _auth.isSuccess.value
                                                              ? Get.offAndToNamed(
                                                                  "/mobile-home")
                                                              : null;
                                                        });
                                                      }
                                                    },
                                                    backgroundColor: baseColor,
                                                    title: "Sign In",
                                                    fontSize: 16.sp,
                                                    textColor: Colors.white),
                                          )),
                                      Obx(
                                        () => _auth.load.value
                                            ? const SizedBox()
                                            : GestureDetector(
                                                onTap: () =>
                                                    Get.toNamed('/mobile-send'),
                                                child: Text(
                                                  'Forgot Password?',
                                                  style:
                                                      monserratMedium.copyWith(
                                                          color: baseColor,
                                                          fontSize: 16.sp),
                                                ),
                                              ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    BottomContainer(
                        buttonText: "Sign Up",
                        text: "Don't have an account?",
                        func: () => Get.offAndToNamed('/mobile-register'))
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
