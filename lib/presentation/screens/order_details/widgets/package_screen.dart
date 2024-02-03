import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manadeeb/core/utils/insets.dart';
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
              return isWide(context) ? _buildLargeScreen(package)
                  :
              _buildSmallScreen(package);
            },
          )
        ],
      ),
    );
  }

  Widget _buildSmallScreen(Package package) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      child: ListView(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        children: [
          _buildHeaderSmall(package),
          const SizedBox(height: 24.0),
          _buildNotes(package),
        ],
      ),
    );
  }

  Widget _buildLargeScreen(Package package) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: _buildHeaderLarge(package),
          ),
          const SizedBox(width: 24.0),
          Expanded(
              flex: 3,
              child: _buildNotes(package),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderSmall(Package package) {
    return Column(
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
      ],
    );
  }

  Widget _buildHeaderLarge(Package package) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              Text(
                package.name ?? '',
                style: getLargeStyle(),
              ),
              const SizedBox(height: 8.0,),
              Text(
                '${package.price ?? ''} د.ك',
                style: getSmallStyle(
                  color: ColorManager.secondary,
                ),
              ),
              const SizedBox(height: 24.0,),
              Text(
                package.description ?? '',
                style: getLargeStyle(
                  color: ColorManager.grey,
                ),
              ),
              const SizedBox(height: 8.0,),
              Text(
                package.class1 ?? '',
                style: getSmallStyle(
                  color: ColorManager.grey,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNotes(Package package) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            AppStrings.notes,
            style: getLargeStyle(),
          ),
        ),
        const SizedBox(height: 8.0),
        PackageNotes(books: package.book ?? []),
      ],
    );
  }
}
