import 'package:ask_ai/controllers/auth.dart';
import 'package:ask_ai/mobile_tablet/widgets/animations.dart';
import 'package:ask_ai/utils/colors.dart';
import 'package:ask_ai/utils/fonts.dart';
import 'package:ask_ai/web/widgets/auth_button.dart';
import 'package:ask_ai/web/widgets/auth_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AuthForm extends StatelessWidget {
  AuthForm({Key? key}) : super(key: key);
  final _auth = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.r),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                "assets/images/logo.png",
                height: 40.h,
              ),
              Padding(
                  padding: EdgeInsets.only(left: 5.w),
                  child: Text(
                    "ChatAI",
                    style: monserratSemiBold.copyWith(
                        color: baseColor, fontSize: 19.sp),
                  )),
            ],
          ),
          const Spacer(),
          Obx(() => _auth.state.value == 0
              ? _RegisterForm()
              : _auth.state.value == 1
                  ? _LoginForm()
                  : _auth.state.value == 2
                      ? _VerifyForm()
                      : _auth.state.value == 3
                          ? _EmailForm()
                          : _RenewPassword()),
          const Spacer(),
        ],
      ),
    );
  }
}

class _RegisterForm extends StatelessWidget {
  _RegisterForm({Key? key}) : super(key: key);
  final _username = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _auth = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width / 9, vertical: 50.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Sign Up",
            style: monserratSemiBold.copyWith(fontSize: 27.sp),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.h, bottom: 40.h),
            child: Text(
              "Create an account",
              style: monserratMedium.copyWith(
                  color: black.withOpacity(0.75), fontSize: 22.sp),
            ),
          ),
          WebAuthField(
              controller: _username,
              hint: "Username",
              iconData: Icons.person_outline),
          Padding(
              padding: EdgeInsets.symmetric(vertical: 30.h),
              child: WebAuthField(
                  controller: _email,
                  hint: "Email",
                  iconData: Icons.email_outlined)),
          WebAuthField(
              controller: _password,
              hint: "Password",
              iconData: Icons.lock_outline,
              obscure: true),
          Padding(
            padding: EdgeInsets.only(top: 50.h),
            child: Obx(
              () => _auth.load.value
                  ? CenterLoad()
                  : Column(
                      children: [
                        WebAuthButton(
                            text: "Create new account",
                            func: () => _auth
                                .register(
                                    _username.text, _email.text, _password.text)
                                .then((value) => _auth.state.value =
                                    _auth.isSuccess.value
                                        ? 2
                                        : _auth.state.value),
                            textColor: Colors.white,
                            buttonColor: baseColor),
                        Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 25.h),
                            child: Text(
                              "OR",
                              style: monserratSemiBold.copyWith(
                                  fontSize: 18.sp, color: Colors.grey.shade600),
                            ),
                          ),
                        ),
                        WebAuthButton(
                          func: () {
                            _password.clear();
                            _username.clear();
                            _email.clear();
                            _auth.state.value = 1;
                          },
                          text: "Login with exist account",
                          textColor: Colors.white,
                          buttonColor: Colors.green.shade400,
                        )
                      ],
                    ),
            ),
          )
        ],
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  _LoginForm({Key? key}) : super(key: key);
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _auth = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width / 9, vertical: 50.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Sign In",
            style: monserratSemiBold.copyWith(fontSize: 27.sp),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
            child: Text(
              "Sign in your account",
              style: monserratMedium.copyWith(
                  color: black.withOpacity(0.75), fontSize: 22.sp),
            ),
          ),
          Padding(
              padding: EdgeInsets.symmetric(vertical: 30.h),
              child: WebAuthField(
                  controller: _email,
                  hint: "Email",
                  iconData: Icons.email_outlined)),
          WebAuthField(
              controller: _password,
              hint: "Password",
              iconData: Icons.lock_outline,
              obscure: true),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                  padding: EdgeInsets.only(top: 10.h),
                  child: TextButton(
                      onPressed: () => _auth.state.value = 3,
                      child: Text(
                        "Forgot your password?",
                        style: monserratMedium.copyWith(
                            color: baseColor, fontSize: 17.sp),
                      )))
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 50.h),
            child: Obx(() => _auth.load.value
                ? const CenterLoad()
                : Column(
                    children: [
                      WebAuthButton(
                          text: "Login",
                          func: () => _auth
                                  .loginWeb(_email.text, _password.text)
                                  .then((value) {
                                if (_auth.isSuccess.value) {
                                  Get.offAndToNamed("/home");
                                }
                              }),
                          textColor: Colors.white,
                          buttonColor: baseColor),
                      Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 25.h),
                          child: Text(
                            "OR",
                            style: monserratSemiBold.copyWith(
                                fontSize: 18.sp, color: Colors.grey.shade600),
                          ),
                        ),
                      ),
                      WebAuthButton(
                        func: () {
                          _auth.email.value = "";
                          _password.clear();
                          _email.clear();
                          _auth.state.value = 0;
                        },
                        text: "Create a new account",
                        textColor: Colors.white,
                        buttonColor: Colors.green.shade400,
                      )
                    ],
                  )),
          )
        ],
      ),
    );
  }
}

class _VerifyForm extends StatelessWidget {
  _VerifyForm({Key? key}) : super(key: key);
  final _code = TextEditingController();
  final _auth = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width / 9, vertical: 50.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Verify",
            style: monserratSemiBold.copyWith(fontSize: 27.sp),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.h, bottom: 40.h),
            child: Text(
              "Verify your account",
              style: monserratMedium.copyWith(
                  color: black.withOpacity(0.75), fontSize: 22.sp),
            ),
          ),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "We send a verification code to ",
                  style: monserratMedium.copyWith(
                      fontSize: 18.sp), // Default color
                ),
                TextSpan(
                  text: _auth.email.value,
                  style: monserratSemiBold.copyWith(
                      fontSize: 18.sp, color: baseColor), // Change color here
                ),
                TextSpan(
                  text: " email address.",
                  style: monserratMedium.copyWith(
                      fontSize: 18.sp), // Default color
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 30.h),
            child: WebAuthField(
                controller: _code,
                hint: "Verification code",
                iconData: Icons.lock_outline),
          ),
          Padding(
            padding: EdgeInsets.only(top: 50.h),
            child: Obx(() => _auth.load.value
                ? const CenterLoad()
                : Column(
                    children: [
                      WebAuthButton(
                          text: "Verify account",
                          func: () => _auth
                                  .verifyUser(
                                      int.parse(_code.text.isNumericOnly
                                          ? _code.text
                                          : "0000"),
                                      true)
                                  .then((value) {
                                if (_auth.isSuccess.value) {
                                  _auth.box.write("web-page", 1);
                                  Get.offAndToNamed("/home");
                                }
                              }),
                          textColor: Colors.white,
                          buttonColor: baseColor),
                      Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 25.h),
                          child: Text(
                            "OR",
                            style: monserratSemiBold.copyWith(
                                fontSize: 18.sp, color: Colors.grey.shade600),
                          ),
                        ),
                      ),
                      WebAuthButton(
                        func: () {
                          _auth.email.value = "";
                          _auth.state.value = 1;
                        },
                        text: "Login with exist account",
                        textColor: Colors.white,
                        buttonColor: Colors.green.shade400,
                      )
                    ],
                  )),
          )
        ],
      ),
    );
  }
}

class _RenewPassword extends StatelessWidget {
  _RenewPassword({Key? key}) : super(key: key);
  final _code = TextEditingController();
  final _password = TextEditingController();
  final _auth = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width / 9, vertical: 50.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Change Password",
            style: monserratSemiBold.copyWith(fontSize: 27.sp),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.h, bottom: 40.h),
            child: Text(
              "Change your user password",
              style: monserratMedium.copyWith(
                  color: black.withOpacity(0.75), fontSize: 22.sp),
            ),
          ),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "We send a verification code to ",
                  style: monserratMedium.copyWith(
                      fontSize: 18.sp), // Default color
                ),
                TextSpan(
                  text: _auth.email.value,
                  style: monserratSemiBold.copyWith(
                      fontSize: 18.sp, color: baseColor), // Change color here
                ),
                TextSpan(
                  text: " email address.",
                  style: monserratMedium.copyWith(
                      fontSize: 18.sp), // Default color
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 30.h),
            child: WebAuthField(
                controller: _code,
                hint: "Verification code",
                iconData: Icons.lock_outline),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 30.h),
            child: WebAuthField(
              controller: _password,
              hint: "New password",
              iconData: Icons.lock,
              obscure: true,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 50.h),
            child: Obx(() => _auth.load.value
                ? const CenterLoad()
                : Column(
                    children: [
                      WebAuthButton(
                          text: "Change Password",
                          func: () => _auth
                                  .changePassword(
                                      _auth.email.value,
                                      int.parse(_code.text.isNumericOnly
                                          ? _code.text
                                          : "0000"),
                                      _password.text)
                                  .then((value) {
                                if (_auth.isSuccess.value) {
                                  _auth.email.value = "";
                                  _auth.state.value = 1;
                                }
                              }),
                          textColor: Colors.white,
                          buttonColor: baseColor),
                      Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 25.h),
                          child: Text(
                            "OR",
                            style: monserratSemiBold.copyWith(
                                fontSize: 18.sp, color: Colors.grey.shade600),
                          ),
                        ),
                      ),
                      WebAuthButton(
                        func: () {
                          _auth.email.value = "";
                          _auth.state.value = 1;
                        },
                        text: "Login with exist account",
                        textColor: Colors.white,
                        buttonColor: Colors.green.shade400,
                      )
                    ],
                  )),
          )
        ],
      ),
    );
  }
}

class _EmailForm extends StatelessWidget {
  _EmailForm({Key? key}) : super(key: key);
  final _email = TextEditingController();
  final _auth = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width / 9, vertical: 50.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Send Code",
            style: monserratSemiBold.copyWith(fontSize: 27.sp),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.h, bottom: 40.h),
            child: Text(
              "Type your email address",
              style: monserratMedium.copyWith(
                  color: black.withOpacity(0.75), fontSize: 22.sp),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20.h),
            child: WebAuthField(
                controller: _email,
                hint: "Email",
                iconData: Icons.email_outlined),
          ),
          Padding(
            padding: EdgeInsets.only(top: 50.h),
            child: Obx(() => _auth.load.value
                ? const CenterLoad()
                : Column(
                    children: [
                      WebAuthButton(
                          text: "Send Code",
                          func: () {
                            _auth.email.value = _email.text;
                            _auth.setLoad();
                            _auth.sendCode().then((value) {
                              if (_auth.isSuccess.value) {
                                _auth.state.value = 5;
                              }
                              _auth.setLoad();
                            });
                          },
                          textColor: Colors.white,
                          buttonColor: baseColor),
                      Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 25.h),
                          child: Text(
                            "OR",
                            style: monserratSemiBold.copyWith(
                                fontSize: 18.sp, color: Colors.grey.shade600),
                          ),
                        ),
                      ),
                      WebAuthButton(
                        func: () {
                          _auth.email.value = "";
                          _auth.state.value = 1;
                        },
                        text: "Login with exist account",
                        textColor: Colors.white,
                        buttonColor: Colors.green.shade400,
                      )
                    ],
                  )),
          )
        ],
      ),
    );
  }
}
