import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manadeeb/presentation/screens/widgets/dialogs/sign_out_dialog.dart';
import 'package:manadeeb/presentation/screens/widgets/home_app_bar/user_image.dart';

import '../../../resources/color_manager.dart';
import '../../auth/auth_controller.dart';
import '../../auth/login/widgets/login_screen.dart';
import 'account_column.dart';

class HomeAppBar extends StatelessWidget {

  final AuthController _controller = Get.find<AuthController>();
  HomeAppBar({super.key});

  void _login() {
    if (_controller.isUserLoggedIn()) {
      // Navigate to Profile
    } else {
      // Navigate to login screen
      Get.to(() => const LoginScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          top: 12.0,
          bottom: 12.0,
          right: 16.0,
          left: 16.0,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(onTap: _login, child: const UserImage()),
          const SizedBox(width: 8,),
          InkWell(onTap: _login, child: AccountColumn()),
          Expanded(child: Container()),
          // Notifications Button
          // Container(
          //   height: 32,
          //   width: 32,
          //   decoration: BoxDecoration(
          //       shape: BoxShape.rectangle,
          //       borderRadius: const BorderRadius.all(Radius.circular(8)),
          //       border: Border.all(color: ColorManager.secondary)
          //   ),
          //   child: IconButton(
          //     onPressed: () {
          //       // Get.to(() => NotificationsScreen());
          //     },
          //     icon: const Icon(
          //       Icons.notifications,
          //       size: 15,
          //       color: ColorManager.secondary,
          //     ),
          //   ),
          // ),
          const SizedBox(width: 8.0,),
          // Sign out Button
          Container(
            height: 32,
            width: 32,
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                border: Border.all(color: ColorManager.secondary)
            ),
            child: IconButton(
              onPressed: () {
                showSignOutDialog(context);
              },
              icon: const Icon(
                Icons.exit_to_app,
                size: 15,
                color: ColorManager.secondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
