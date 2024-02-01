import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manadeeb/presentation/resources/styles_manager.dart';
import 'package:manadeeb/presentation/screens/add_order/controller/add_order_controller.dart';

import '../../../../resources/color_manager.dart';
import '../../../../resources/values_manager.dart';

class NotesQuantityWidget extends StatelessWidget {

  final int index;
  const NotesQuantityWidget({super.key, required this.index});

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
                      controller.decrementCountBook(index);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Text(
                        '-',
                        style: getLargeStyle(),
                                      ),
                    )),
                Text(
                  controller.booksQuantity[index].toString(),
                  style: getLargeStyle(),
                ),
                // + Button
                InkWell(
                    onTap: () {
                      debugPrint('Plus Clicked');
                      controller.incrementCountBook(index);
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
