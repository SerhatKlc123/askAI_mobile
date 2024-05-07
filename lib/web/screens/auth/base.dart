import 'package:ask_ai/web/screens/auth/forms/auth_forms.dart';
import 'package:ask_ai/web/screens/common/onboarding.dart';
import 'package:flutter/material.dart';


class WebAuthBase extends StatelessWidget {
  const WebAuthBase({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // For all forms will be in here
          Expanded(
              flex: 3,
              child: AuthForm()),

          // Simple onBoarding will be here
          Expanded(
              flex: 2,
              child: WebOnBoarding())

        ],
      ),
    );
  }
}
