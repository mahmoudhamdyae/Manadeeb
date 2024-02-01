import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manadeeb/presentation/resources/styles_manager.dart';
import 'package:manadeeb/presentation/screens/add_order/controller/add_order_controller.dart';

import '../../../../resources/color_manager.dart';
import '../../../../resources/values_manager.dart';

class PackagesQuantityWidget extends StatelessWidget {

  final int index;
  const PackagesQuantityWidget({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return GetX<AddOrderController>(
      init: Get.find<AddOrderController>(),
      builder: (AddOrderController controller) {
        return Container(
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
              border: Border.all(color: ColorManager.grey)
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 8.0),
            child: Row(
              children: [
                // - Button
                InkWell(
                    onTap: () {
                      debugPrint('Minus Clicked');
                      controller.decrementCountPackage(index);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Text(
                        '-',
                        style: getLargeStyle(),
                      ),
                    )),
                Text(
                  controller.packagesQuantity[index].toString(),
                  style: getLargeStyle(),
                ),
                // + Button
                InkWell(
                  onTap: () {
                    debugPrint('Plus Clicked');
                    controller.incrementCountPackage(index);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text(
                      '+',
                      style: getLargeStyle(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
