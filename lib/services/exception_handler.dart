import 'package:ask_ai/mobile_tablet/widgets/snack.dart';

class ExceptionHandler {
  static void defaultHandler() => errorBar(
      "Something unexpected happened. We're sorry for the inconvenience. Please try again later.");

  // We can define all Http status error codes in handler function
  static void handler(int statusCode) {
    switch (statusCode) {
      case 500:
        errorBar(
            "Something went wrong. We apologize for the inconvenience. Please try again later.");
        break;
      case 401:
        errorBar(
            "Access to this resource is restricted. Please make sure you are logged in.");
        break;
      default:
        errorBar(
            "Something unexpected happened. We're sorry for the inconvenience. Please try again later.");
        break;
    }
  }
}
