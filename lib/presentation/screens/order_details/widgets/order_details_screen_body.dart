import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manadeeb/presentation/resources/color_manager.dart';
import 'package:manadeeb/presentation/resources/strings_manager.dart';
import 'package:manadeeb/presentation/resources/styles_manager.dart';
import 'package:manadeeb/presentation/screens/order_details/controller/order_details_controller.dart';
import 'package:manadeeb/presentation/screens/order_details/widgets/notes_list_view.dart';
import 'package:manadeeb/presentation/screens/order_details/widgets/packages_list_view.dart';

class OrderDetailsScreenBody extends StatelessWidget {

  const OrderDetailsScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
      child: GetX<OrderDetailsController>(
        init: Get.find<OrderDetailsController>(),
        builder: (OrderDetailsController controller) {
          return ListView(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            children: [
              FilledButton(
                style: getFilledButtonStyle(),
                onPressed: () {
                  controller.receiveOrder(controller.orderId);
                },
                child: Text(
                  '${AppStrings.receiveOrder} ${controller.total} د.ك',
                  style: getLargeStyle(
                    color: ColorManager.white,
                  ),
                ),
              ),
              const SizedBox(height: 8.0,),
              controller.isBook.value ? Text(
                AppStrings.notes,
                style: getLargeStyle(),
              ) : Container(),
              const SizedBox(height: 8.0,),
              GetX<OrderDetailsController>(
                init: Get.find<OrderDetailsController>(),
                builder: (OrderDetailsController controller) {
                  return NotesListView(books: controller.books, orderDetails: controller.order.value.orderdetails ?? [],);
                },
              ),
              const SizedBox(height: 16.0,),
              controller.isPackage.value ? Text(
                AppStrings.packages,
                style: getLargeStyle(),
              ) : Container(),
              const SizedBox(height: 8.0,),
              const PackagesListView(),
            ],
          );
        },
      ),
    );
  }
}
