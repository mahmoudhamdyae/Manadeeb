import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manadeeb/presentation/resources/color_manager.dart';
import 'package:manadeeb/presentation/resources/styles_manager.dart';
import 'package:manadeeb/presentation/screens/add_order/controller/add_order_controller.dart';
import 'package:manadeeb/presentation/screens/add_order/widgets/packages/packages_quantity_widget.dart';

class TabPackageItem extends StatelessWidget {

  final int index;
  const TabPackageItem({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return GetX<AddOrderController>(
      init: Get.find<AddOrderController>(),
      builder: (AddOrderController controller) {
        return Row(
          children: [
            Checkbox(
              value: controller.checkedPackages[index],
              onChanged: (isSelected) => controller.checkPackage(index, isSelected ?? false),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  controller.packages[index].name ?? '',
                  style: getLargeStyle(),
                ),
                const SizedBox(height: 8.0,),
                Text(
                  controller.packages[index].class1 ?? '',
                  style: getSmallStyle(
                      color: ColorManager.grey
                  ),
                ),
              ],
            ),
            Expanded(child: Container()),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: PackagesQuantityWidget(index: index),
            )
          ],
        );
      },
    );
  }
}
