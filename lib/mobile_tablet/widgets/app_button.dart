import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../utils/fonts.dart';

class AppButton extends StatelessWidget {
  AppButton(
      {Key? key,
      required this.onPressed,
      required this.backgroundColor,
      required this.title,
      required this.textColor,
      this.elevation,
      this.fontSize,
      this.height})
      : super(key: key);
  final Function() onPressed;
  final Color backgroundColor, textColor;
  final String title;
  final double? elevation, height, fontSize;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: elevation,
        backgroundColor: backgroundColor,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
        fixedSize: Size(MediaQuery.of(context).size.width, height ?? 50.h),
      ),
      child: Text(
        title,
        style: monserratMedium.copyWith(
            color: textColor, fontSize: fontSize ?? 17.sp),
      ),
    );
  }
}
