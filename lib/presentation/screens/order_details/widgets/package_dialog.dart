import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manadeeb/presentation/resources/strings_manager.dart';
import 'package:manadeeb/presentation/resources/styles_manager.dart';
import 'package:manadeeb/presentation/screens/order_details/controller/package_controller.dart';

import '../../widgets/error_screen.dart';
import '../../widgets/loading_screen.dart';

class PackageDialog extends StatelessWidget {

  const PackageDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Center(
          child: Text(
            AppStrings.packageDetails,
            style: getLargeStyle(),
          ),
        ),
        GetX<PackageController>(
          init: Get.find<PackageController>(),
          builder: (PackageController controller) {
            if(controller.status.isLoading) {
              return const LoadingScreen();
            } else if (controller.status.isError) {
              return ErrorScreen(error: controller.status.errorMessage ?? '');
            }
            return Text(controller.package.value.name ?? '');
          },
        )
      ],
    );
  }
}
