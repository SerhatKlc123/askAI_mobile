import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/colors.dart';
import '../../utils/fonts.dart';

class WebAuthButton extends StatelessWidget {
  const WebAuthButton({Key? key, required this.func, required this.text, required this.textColor, required this.buttonColor})
      : super(key: key);
  final Function() func;
  final String text;
  final Color textColor, buttonColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: func,
      style: ElevatedButton.styleFrom(
          fixedSize: Size(MediaQuery.of(context).size.width, 70.h),
          backgroundColor: buttonColor),
      child: Text(
        text,
        style: monserratSemiBold.copyWith(color: textColor, fontSize: 18.sp),
      ),
    );
  }
}
