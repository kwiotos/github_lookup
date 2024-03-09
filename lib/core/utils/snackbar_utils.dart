import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../translations/translations.gl.dart';

class SnackBarUtils {
  static void showErrorSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(LocaleKeys.base_error_message.tr()),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        backgroundColor: Colors.red,
        margin: EdgeInsets.only(
          bottom: MediaQuery.sizeOf(context).height - 70,
          right: 10,
          left: 10,
        ),
      ),
    );
  }
}
