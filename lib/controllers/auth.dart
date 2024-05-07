import 'package:ask_ai/services/api.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../mobile_tablet/widgets/snack.dart';

class AuthController extends GetxController {
  final load = false.obs;
  final box = GetStorage();
  final email = ''.obs;
  final isSuccess = false.obs;
  // For web if state = 0 then register, = 1 login, = 2 verify, = 3 renew
  final state = 0.obs;

  Future<void> register(String username, String email, String password) async {
    setLoad();
    isSuccess.value = false;
    Get.focusScope?.unfocus();
    try {
      var form = {'username': username, 'email': email, 'password': password};
      var response = await ApiService.dio.post(ApiService.register, data: form);
      var data = response.data;
      if (data['code'] > 0) {
        errorBar(data['message']);
      } else {
        this.email.value = email;
        isSuccess.value = true;
        successBar(data["message"]);
      }
    } catch (error) {
      errorBar(error.toString());
    }
    setLoad();
  }

  Future<void> login(String email, String password, String path) async {
    setLoad();
    Get.focusScope?.unfocus();
    isSuccess.value = false;
    try {
      this.email.value = email;

      final response = await http.post(
        Uri.parse("${ApiService.baseUrl}${ApiService.login}"),
        body: {
          'username': email,
          'password': password,
        },
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      );

      var data = jsonDecode(utf8.decode(response.bodyBytes));
      if (data['code'] == 102) {
        errorBar(data['message']);
        sendCode().then((value) => Get.offAndToNamed(path));
      } else if (data["code"] > 0) {
        errorBar(data["message"]);
      } else {
        box.write('token', data['access_token']);
        box.write('email', email);
        box.write('page', 2);
        isSuccess.value = true;
      }
      print(data);
    } catch (error) {
      errorBar(error.toString());
    }
    setLoad();
  }

  Future<void> loginWeb(String email, String password) async {
    setLoad();
    Get.focusScope?.unfocus();
    isSuccess.value = false;
    try {
      this.email.value = email;

      final response = await http.post(
        Uri.parse("${ApiService.baseUrl}${ApiService.login}"),
        body: {
          'username': email,
          'password': password,
        },
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      );

      var data = jsonDecode(utf8.decode(response.bodyBytes));
      if (data['code'] == 102) {
        errorBar(data['message']);
        sendCode().then((value) => state.value = 2);
      } else if (data["code"] > 0) {
        errorBar(data["message"]);
      } else {
        box.write('token', data['access_token']);
        box.write('email', email);
        box.write('web-page', 1);
        isSuccess.value = true;
      }
      print(data);
    } catch (error) {
      errorBar(error.toString());
    }
    setLoad();
  }

  Future<void> verifyUser(int code, bool web) async {
    setLoad();
    isSuccess.value = false;
    Get.focusScope?.unfocus();
    try {
      var form = {'email': email.value, 'verification_code': code};
      var response =
          await ApiService.dio.post(ApiService.verifyUser, data: form);
      var data = response.data;
      if (data['code'] > 0) {
        errorBar(data['message']);
      } else if (data['code'] == 0) {
        successBar(data["message"]);
        box.write('token', data['access_token']);
        box.write('email', email.value);
        box.write('page', 2);
        web ? box.write('web-page', 1) : null;
        isSuccess.value = true;
      }
    } catch (error) {
      errorBar(error.toString());
    }
    setLoad();
  }

  Future<void> changePassword(String mail, int code, String password) async {
    setLoad();
    isSuccess.value = false;
    Get.focusScope?.unfocus();
    try {
      var form = {
        'verification_code': code,
        'email': mail,
        'password': password
      };
      var response =
          await ApiService.dio.post(ApiService.renewPassword, data: form);
      var data = response.data;
      if (data['code'] > 0) {
        errorBar(data['message']);
      } else if (data['code'] == 0) {
        isSuccess.value = true;
        successBar(data["message"]);
      }
    } catch (error) {
      print(error);
      errorBar(error.toString());
    }
    setLoad();
  }

  Future<void> sendCode() async {
    isSuccess.value = false;
    Get.focusScope?.unfocus();
    try {
      var form = {'email': email.value};
      var response =
          await ApiService.dio.post(ApiService.sendVerification, data: form);
      var data = response.data;
      if (data['code'] > 0) {
        errorBar(data['message']);
      } else {
        successBar(data["message"] ?? "");
        isSuccess.value = true;
      }
    } catch (error) {
      errorBar(error.toString());
    }
  }

  void setLoad() => load.value = !load.value;

  @override
  void onInit() {
    load.value = false;
    super.onInit();
  }
}
