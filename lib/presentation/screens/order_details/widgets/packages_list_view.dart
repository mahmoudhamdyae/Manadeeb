import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manadeeb/presentation/resources/strings_manager.dart';
import 'package:manadeeb/presentation/resources/styles_manager.dart';
import 'package:manadeeb/presentation/screens/order_details/controller/package_controller.dart';
import 'package:manadeeb/presentation/screens/order_details/widgets/package_screen.dart';

import '../../../../core/utils/insets.dart';
import '../../../../domain/models/order_details.dart';
import '../../../resources/color_manager.dart';
import '../controller/order_details_controller.dart';

class PackagesListView extends StatelessWidget {

  const PackagesListView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<OrderDetailsController>(
        init: Get.find<OrderDetailsController>(),
        builder: (OrderDetailsController controller) {
          return isWide(context) ? _buildTwoColumnList(context, controller)
              :
              _buildOneColumnList(controller);
          },
    );
  }

  Widget _buildOneColumnList(OrderDetailsController controller) {
    return ListView.builder(
      itemCount: controller.order.value.orderdetails?.length ?? 0,
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return _buildItem(controller.order.value, index);
      },
    );
  }

  Widget _buildTwoColumnList(BuildContext context, OrderDetailsController controller) {
    return GridView.count(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      crossAxisCount:(MediaQuery.of(context).size.width ~/ 210).toInt(),
      childAspectRatio: 1.5,
      children: List.generate(controller.order.value.orderdetails?.length ?? 0, (index) {
        return _buildItem(controller.order.value, index);
      }),
    );
  }

  Widget _buildItem(OrderDetailsResponse order, int index) {
    Map<String, dynamic>? packages = order.orderdetails?[index].package;
    return packages == null ? Container() : Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(16.0)),
        border: Border.all(
          color: ColorManager.lightGrey,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                packages['name'] ?? '',
                style: getLargeStyle(),
              ),
              Text(
                '${packages['price'] ?? ''} د.ك',
                style: getLargeStyle(
                  color: ColorManager.secondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                packages['class'] ?? '',
                style: getSmallStyle(
                    color: ColorManager.grey
                ),
              ),
              Text(
                '${AppStrings.quantity}: ${(order.orderdetails?[index].quantity ?? 0)}',
                style: getSmallStyle(
                    color: ColorManager.grey
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0,),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              style: getOutlinedButtonStyle(),
              onPressed: () {
                Get.find<PackageController>().getPackage(packages['id']);
                Get.to(() => const PackageScreen());
              },
              child: Text(
                AppStrings.packageDetails,
                style: getSmallStyle(
                  color: ColorManager.primary,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
