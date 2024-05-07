import 'package:ask_ai/controllers/platform.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../utils/colors.dart';
import 'curved_container.dart';

class AuthCurvedDisplay extends StatelessWidget {
  AuthCurvedDisplay({Key? key, required this.children}) : super(key: key);
  final Widget children;
  final _platform = Get.find<PlatformController>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          Column(
            children: [
              Expanded(
                  flex: _platform.isTablet() ? 3 : 2, child: const SizedBox()),
              Expanded(
                  flex: _platform.isTablet() ? 5 : 3,
                  child: CurvedContainer(
                    color: baseColor,
                  ))
            ],
          ),
          children
        ],
      ),
    );
  }
}
