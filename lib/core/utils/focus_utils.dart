import 'package:flutter/widgets.dart';

class FocusUtils {
  static void hideKeyboard(BuildContext context) {
    if (hasFocus(context)) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

  static bool hasFocus(BuildContext context) {
    final FocusScopeNode currentFocus = FocusScope.of(context);

    return !currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null;
  }
}
