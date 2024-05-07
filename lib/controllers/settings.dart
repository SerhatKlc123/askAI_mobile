import 'package:ask_ai/controllers/chat.dart';
import 'package:ask_ai/controllers/navbar.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SettingsController extends GetxController {
  final _box = GetStorage();

  String getMail() => _box.read("email") ?? "";

  void signOut() {
    // Remove memory values before the logout
    _box.remove("token");
    _box.remove("email");
    _box.write("page", 1);
    Get.toNamed("/mobile-register");
    Get.delete<NavbarController>();
    Get.delete<ChatController>();
  }

  void webSignOut() {
    // Remove memory values before the logout
    _box.remove("token");
    _box.remove("email");
    _box.write("page", 1);
    _box.remove("web-page");
    Get.delete<NavbarController>();
    Get.delete<ChatController>();
    Get.delete();
    Get.toNamed("/");
  }



}
