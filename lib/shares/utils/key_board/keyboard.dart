import 'package:get/get.dart';

class KeyBoard {
  static void hide() {
    //   FocusManager.instance.primaryFocus?.unfocus();
    Get.focusScope!.unfocus();
  }

  static RxBool keyboardIsVisible() {
    return (Get.mediaQuery.viewInsets.bottom != 0.0).obs;
  }
}
