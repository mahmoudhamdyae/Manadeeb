import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../resources/color_manager.dart';
import '../../../resources/strings_manager.dart';
import '../../../resources/styles_manager.dart';
import '../../auth/auth_controller.dart';
import '../../auth/login/widgets/login_screen.dart';

showSignOutDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        title: Text(
          AppStrings.logoutDialogTitle,
          style: getLargeStyle(),
        ),
        content: Text(
          AppStrings.logoutDialogText,
          style: getSmallStyle(),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
                AppStrings.cancel,
                style: getSmallStyle()),
          ),
          FilledButton(
            style: getFilledButtonStyle(),
            onPressed: _signOut,
            child: Text(
              AppStrings.logoutOk,
              style: getSmallStyle(
                  color: ColorManager.white
              ),
            ),
          )
        ],
      );
    },
  );
}

_signOut() async {
  Get.find<AuthController>().signOut()
      .then((value) => Get.offAll(() => const LoginScreen()));
}