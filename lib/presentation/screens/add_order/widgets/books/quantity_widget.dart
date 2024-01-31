import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:manadeeb/presentation/resources/styles_manager.dart';
import 'package:manadeeb/presentation/screens/add_order/controller/add_order_controller.dart';

import '../../../../resources/color_manager.dart';
import '../../../../resources/values_manager.dart';

class QuantityWidget extends StatelessWidget {

  final int index;
  const QuantityWidget({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return GetX<AddOrderController>(
      builder: (AddOrderController controller) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 0.0),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
              border: Border.all(color: ColorManager.grey)
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            child: Row(
              children: [
                // - Button
                InkWell(
                    onTap: () {
                      debugPrint('Minus Clicked');
                      controller.decrementCountBook(index);
                    },
                    child: Text(
                      '-',
                      style: getLargeStyle(),
                )),
                const SizedBox(width: 2.0,),
                Padding(
                  padding: const EdgeInsets.only(
                    right: 8.0,
                    left: 8.0,
                    top: 6,
                  ),
                  child: Text(
                    controller.booksQuantity[index].toString(),
                    style: getLargeStyle(

                    ),
                  ),
                ),
                const SizedBox(width: 2.0,),
                // + Button
                InkWell(
                    onTap: () {
                      debugPrint('Plus Clicked');
                      controller.incrementCountBook(index);
                    },
                    child: Text(
                      '+',
                      style: getLargeStyle(),
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
