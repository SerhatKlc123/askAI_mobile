import 'package:ask_ai/controllers/chat.dart';
import 'package:ask_ai/mobile_tablet/widgets/animations.dart';
import 'package:ask_ai/utils/colors.dart';
import 'package:ask_ai/web/home/chat.dart';
import 'package:ask_ai/web/home/sidebar.dart';
import 'package:ask_ai/web/screens/auth/base.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class WebHome extends StatelessWidget {
  WebHome({Key? key}) : super(key: key);
  final _chat = Get.put(ChatController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(
      () => _chat.load.value
          ? const CenterLoad()
          : Row(
              children: [
                Expanded(
                    flex: 2,
                    child: SideBar()),
                Expanded(flex: 7, child: WebChatPage()),
              ],
            ),
    ));
  }
}
