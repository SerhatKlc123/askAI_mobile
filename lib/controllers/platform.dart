import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

// Define device types
enum PlatformType { web, tablet, phone }

class PlatformController extends GetxController {
  PlatformType platformType = PlatformType.phone;

  // Get current platform for usage
  Future<void> getPlatform(BuildContext ctx) async {
    if (kIsWeb) {
      platformType = PlatformType.web;
    }
    // If device width greater or equal than 600 pixel then return Tablet as device type
    else if (MediaQuery.of(ctx).size.width >= 600) {
      platformType = PlatformType.tablet;
    }
    // Otherwise return phone
    else {
      platformType = PlatformType.phone;
    }
  }

  // Check if tablet
  bool isTablet() {
    return platformType == PlatformType.tablet ? true : false;
  }
}
