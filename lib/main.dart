import 'package:ask_ai/controllers/platform.dart';
import 'package:ask_ai/mobile_tablet/screens/auth/login.dart';
import 'package:ask_ai/mobile_tablet/screens/auth/register.dart';
import 'package:ask_ai/mobile_tablet/screens/auth/renew/renew_password.dart';
import 'package:ask_ai/mobile_tablet/screens/auth/renew/send_code.dart';
import 'package:ask_ai/mobile_tablet/screens/auth/verify.dart';
import 'package:ask_ai/mobile_tablet/screens/common/splash.dart';
import 'package:ask_ai/mobile_tablet/screens/favorites/base.dart';
import 'package:ask_ai/mobile_tablet/screens/favorites/chat.dart';
import 'package:ask_ai/mobile_tablet/screens/navbar/base.dart';
import 'package:ask_ai/mobile_tablet/screens/navbar/chat/chat.dart';
import 'package:ask_ai/utils/colors.dart';
import 'package:ask_ai/web/home/base.dart';
import 'package:ask_ai/web/screens/auth/base.dart';
import 'package:ask_ai/web/screens/common/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  await GetStorage.init();

  // Set device orientation
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  final _platform = Get.put(PlatformController());
  final _box = GetStorage();
  @override
  Widget build(BuildContext context) {
    _platform.getPlatform(context);
    return GetMaterialApp(
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          scrollbarTheme: ScrollbarThemeData(
            thumbColor: MaterialStateProperty.all(
                _platform.platformType == PlatformType.web
                    ? Colors.white.withOpacity(0.5)
                    : baseColor.withOpacity(0.5)),
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            elevation: 0,
          )),

      // Define routes
      getPages: [
        // Mobile routes
        GetPage(name: '/mobile-register', page: () => MobileRegisterScreen()),
        GetPage(name: '/mobile-login', page: () => MobileLoginScreen()),
        GetPage(name: '/mobile-verify', page: () => MobileVerifyScreen()),
        GetPage(name: '/mobile-send', page: () => MobileSendScreen()),
        GetPage(name: '/mobile-renew', page: () => MobileRenewScreen()),
        GetPage(name: '/mobile-home', page: () => NavbarBase()),
        GetPage(name: '/mobile-chat', page: () => ChatScreen()),
        GetPage(name: '/mobile-favorite', page: () => FavoriteScreen()),
        GetPage(
            name: '/mobile-favorite-preview', page: () => FavoriteChatScreen()),
        // Web Routes
        GetPage(name: '/home', page: () => WebHome()),
        GetPage(name: '/', page: () => WebAuthBase()),
      ],
      title: 'Ask AI',
      debugShowCheckedModeBanner: false,
      // Redirect as platform info
      home: _platform.platformType == PlatformType.web
          ? WebSplashScreen()
          : MobileSplashScreen(),
    );
  }
}
