import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../utils/colors.dart';
import '../../utils/fonts.dart';

class NewChatButton extends StatelessWidget {
  NewChatButton({Key? key, required this.func}) : super(key: key);
  final Function() func;
  final _onHover = false.obs;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _onHover.value = true,
      onExit: (_) => _onHover.value = false,
      child: GestureDetector(
        onTap: (){
          _onHover.value = false;
          func();
        },
        child: Obx(
              ()=> Container(
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.r),
                color: _onHover.value ? Colors.grey.shade700 : black
            ),
            child: Row(
              children: [
                LottieBuilder.asset("assets/animations/ob1.json",height: 40.h,),
                Padding(padding: EdgeInsets.only(left: 10.w),
                  child: Text("New Chat", style: monserratSemiBold.copyWith(fontSize: 18.sp, color: Colors.white),),
                ),
                const Spacer(),
                Icon(Icons.add_circle_outlined, color: Colors.white, size: 27.r,)

              ],
            ),
          ),
        ),
      ),
    );
  }
}
