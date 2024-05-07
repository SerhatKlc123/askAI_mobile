import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/colors.dart';
import '../../utils/fonts.dart';

class WebAuthField extends StatelessWidget {
  const WebAuthField({Key? key, required this.controller, required this.hint, required this.iconData, this.obscure}) : super(key: key);
  final TextEditingController controller;
  final String hint;
  final IconData iconData;
  final bool ? obscure;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      cursorColor: baseColor,
      obscureText: obscure ?? false,
      style: monserratMedium.copyWith(color: black, fontSize: 18.sp),
      decoration: InputDecoration(
        prefixIcon: Icon(iconData, size: 26.r, color: baseColor,),
        hintText: hint,
        hintStyle: monserratMedium.copyWith(
            fontSize: 18.sp, color: Colors.grey.shade500),
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
