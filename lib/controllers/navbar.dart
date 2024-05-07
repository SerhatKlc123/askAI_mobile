import 'package:ask_ai/mobile_tablet/screens/navbar/chat/base.dart';
import 'package:ask_ai/mobile_tablet/screens/navbar/settings.dart';
import 'package:get/get.dart';

class NavbarController extends GetxController {
  // Set inital index as 0 which is chat generate page
  final index = 0.obs;
  final screens = [ChatScreen(), SettingScreen()];

  // Change index function
  void setIndex(int index) => this.index.value = index;
}
