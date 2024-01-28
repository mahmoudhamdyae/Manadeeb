import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../resources/color_manager.dart';
import '../../../resources/strings_manager.dart';
import '../../../resources/styles_manager.dart';
import '../../auth/auth_controller.dart';

class AccountColumn extends StatelessWidget {

  final AuthController _controller = Get.find<AuthController>();
  AccountColumn({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.welcomeBack,
          style: getSmallStyle(color: ColorManager.secondary),
        ),
        Text(
          _controller.getUserName(),
          style: getLargeStyle(),
        ),
      ],
    );
  }
}
