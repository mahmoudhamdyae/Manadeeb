import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manadeeb/presentation/resources/color_manager.dart';
import 'package:manadeeb/presentation/resources/strings_manager.dart';
import 'package:manadeeb/presentation/resources/styles_manager.dart';
import 'package:manadeeb/presentation/screens/order_details/controller/package_controller.dart';
import 'package:manadeeb/presentation/screens/order_details/widgets/package_notes.dart';
import 'package:manadeeb/presentation/screens/widgets/top_bar.dart';

import '../../../../domain/models/package.dart';
import '../../widgets/error_screen.dart';
import '../../widgets/loading_screen.dart';

class PackageScreen extends StatelessWidget {

  const PackageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        children: [
          const TopBar(title: AppStrings.packageDetails),
          GetX<PackageController>(
            init: Get.find<PackageController>(),
            builder: (PackageController controller) {
              if(controller.status.isLoading) {
                return const LoadingScreen();
              } else if (controller.status.isError) {
                return ErrorScreen(error: controller.status.errorMessage ?? '');
              }
              Package package = controller.package.value;
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                child: ListView(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            package.name ?? '',
                            style: getLargeStyle(),
                          ),
                          Text(
                            '${package.price ?? ''} د.ك',
                            style: getSmallStyle(
                              color: ColorManager.secondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8.0,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            package.description ?? '',
                            style: getLargeStyle(
                              color: ColorManager.grey,
                            ),
                          ),
                          Text(
                            package.class1 ?? '',
                            style: getSmallStyle(
                              color: ColorManager.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        AppStrings.notes,
                        style: getLargeStyle(),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    PackageNotes(books: controller.package.value.book ?? []),
                  ],
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
