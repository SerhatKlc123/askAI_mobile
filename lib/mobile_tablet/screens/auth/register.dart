import 'package:ask_ai/controllers/auth.dart';
import 'package:ask_ai/controllers/platform.dart';
import 'package:ask_ai/mobile_tablet/widgets/app_button.dart';
import 'package:ask_ai/mobile_tablet/widgets/auth_curved.dart';
import 'package:ask_ai/mobile_tablet/widgets/auth_field.dart';
import 'package:ask_ai/mobile_tablet/widgets/animations.dart';
import 'package:ask_ai/utils/colors.dart';
import 'package:ask_ai/utils/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../widgets/sheet.dart';

class MobileRegisterScreen extends StatelessWidget {
  MobileRegisterScreen({Key? key}) : super(key: key);
  final _auth = Get.put(AuthController());
  final _platform = Get.find<PlatformController>();
  final _username = TextEditingController();
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
                                "Sign Up",
                                style: monserratSemiBold.copyWith(
                                    fontSize:
                                        _platform.isTablet() ? 19.sp : 20.sp),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 5.h),
                                child: Text(
                                  "Create an account",
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
                                      borderRadius: BorderRadius.circular(25.r)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(bottom: 30.h),
                                        child: Image.asset(
                                          "assets/images/logo.png",
                                          height: 100.h,
                                        ),
                                      ),
                                      AuthField(
                                          controller: _username,
                                          icon: Icons.person_outline,
                                          hintText: 'Username'),
                                      Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 20.h),
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
                                          padding: EdgeInsets.only(top: 20.h),
                                          child: Obx(
                                            () => _auth.load.value
                                                ? const Load()
                                                : AppButton(
                                                    onPressed: () => _auth
                                                        .register(
                                                            _username.text,
                                                            _email.text,
                                                            _password.text)
                                                        .then((value) => _auth
                                                                .isSuccess.value
                                                            ? Get.toNamed(
                                                                "/mobile-verify")
                                                            : null),
                                                    backgroundColor: baseColor,
                                                    fontSize: 16.sp,
                                                    title: "Sign Up",
                                                    textColor: Colors.white),
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    BottomContainer(buttonText: "Sign In", text: "Have you already account?", func: () => Get.offAndToNamed('/mobile-login'))

                  ],
                ),
              )),
        ),
      ),
    );
  }
}
