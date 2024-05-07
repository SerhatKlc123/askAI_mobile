import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';


class ObController extends GetxController {
  final _box = GetStorage();
  final index = 0.obs;
  // Create content for on_boarding screen
  final animations = [
    'assets/animations/ob0.json',
    'assets/animations/ob1.json',

  ];
  final title = [
    'Explore Your Curiosity with ChatGPT',
    'Your Personal Knowledge Companion'
  ];
  final subTitle = [
    'Welcome to your gateway to endless knowledge! With our app powered by ChatGPT, you can delve into any topic you desire.',
    'Meet your virtual assistant, ready to assist you at any moment. Whether you\'re pondering the mysteries of the universe or simply seeking quick information.'
  ];

  void goNext() {
    index.value < 1 ? index.value++ : Get.toNamed('/mobile-register');
    index.value == 1 ? _box.write('page', 1) : null;
  }


  void skip() {
    Get.toNamed('/mobile-register');
    _box.write('page', 1);
  }

  void setIndexForWeb() => index.value = index.value == 0 ? 1 : 0;
}
