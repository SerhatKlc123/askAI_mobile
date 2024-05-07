import 'package:ask_ai/controllers/platform.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../utils/colors.dart';
import '../../utils/fonts.dart';

class AuthField extends StatelessWidget {
  AuthField(
      {Key? key,
      required this.controller,
      required this.icon,
      this.isObscure,
      required this.hintText})
      : super(key: key);
  final _platform = Get.find<PlatformController>();
  final TextEditingController controller;
  final IconData icon;
  final String hintText;
  final bool? isObscure;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: monserratMedium.copyWith(
          fontSize: _platform.isTablet() ? 13.sp : 14.sp),
      cursorColor: baseColor,
      obscureText: isObscure ?? false,
      decoration: InputDecoration(
        prefixIconConstraints:
            _platform.isTablet() ? BoxConstraints(minWidth: 40.w) : null,
        contentPadding:
            _platform.isTablet() ? EdgeInsets.all(15.r) : EdgeInsets.all(12.r),
        prefixIcon: Icon(
          icon,
          color: baseColor,
          size: _platform.isTablet() ? 23.r : 24.r,
        ),
        hintText: hintText,
        hintStyle: monserratMedium.copyWith(
            fontSize: 14.sp, color: Colors.grey.shade500),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: BorderSide(color: baseColor)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: BorderSide(color: baseColor)),
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: BorderSide(color: baseColor)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: BorderSide(color: baseColor)),
      ),
    );
  }
}
