import 'package:flutter_easyloading/flutter_easyloading.dart';

class LoaderService {
  static bool shown = false;

  static void displayLoader() {
    if (!shown) EasyLoading.show();
    shown = true;
  }

  static void hideLoader() {
    shown = false;
    EasyLoading.dismiss();
  }
}
