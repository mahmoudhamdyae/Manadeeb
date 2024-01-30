import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manadeeb/domain/models/order_type.dart';
import 'package:manadeeb/presentation/resources/color_manager.dart';
import 'package:manadeeb/presentation/resources/strings_manager.dart';
import 'package:manadeeb/presentation/resources/styles_manager.dart';
import 'package:manadeeb/presentation/screens/home/current_orders/controller/current_orders_controller.dart';
import 'package:manadeeb/presentation/screens/home/new_orders/controller/new_orders_controller.dart';
import 'package:manadeeb/presentation/screens/order_details/controller/order_details_controller.dart';
import 'package:manadeeb/presentation/screens/order_details/widgets/notes_list_view.dart';
import 'package:manadeeb/presentation/screens/order_details/widgets/packages_list_view.dart';
import 'package:manadeeb/presentation/screens/widgets/dialogs/loading_dialog.dart';

import '../../../resources/constants_manager.dart';
import '../../home/delivered_orders/controller/delivered_orders_controller.dart';
import '../../widgets/dialogs/error_dialog.dart';

class OrderDetailsScreenBody extends StatelessWidget {

  const OrderDetailsScreenBody({super.key});

  void receiveOrder() {

  }

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
                  if (Get.arguments['order_type'] == OrderType.newOrder) {
                    showLoading(context);
                    controller.receiveOrder(controller.orderId).then((value) {
                      if (controller.rStatus.isSuccess) {
                        Get.back();
                        // showSuccess(context, AppStrings.successReceiveOrder, () {
                        //   Get.back();
                        Get.back();
                        // controller.getOrderDetails();
                        // });
                        Get.find<NewOrdersController>().getOrders();
                        Get.find<CurrentOrdersController>().getOrders();
                        Get.showSnackbar(
                          const GetSnackBar(
                            title: null,
                            message: AppStrings.successDialogTitle,
                            icon: Icon(Icons.done, color: ColorManager.white,),
                            duration: Duration(seconds: AppConstants.snackBarTime),
                          ),
                        );
                      } else if (controller.rStatus.isError) {
                        Get.back();
                        showError(context, controller.rStatus.errorMessage ?? '', () {});
                      }
                    });
                  } else if (Get.arguments['order_type'] == OrderType.currentOrder) {
                    showLoading(context);
                    controller.moveToCurrent(controller.orderId).then((value) {
                      if (controller.rStatus.isSuccess) {
                        Get.back();
                        // showSuccess(context, AppStrings.successReceiveOrder, () {
                        //   Get.back();
                        Get.back();
                        // controller.getOrderDetails();
                        // });
                        Get.find<CurrentOrdersController>().getOrders();
                        Get.find<DeliveredOrdersController>().getOrders();
                        Get.showSnackbar(
                          const GetSnackBar(
                            title: null,
                            message: AppStrings.successDialogTitle,
                            icon: Icon(Icons.done, color: ColorManager.white,),
                            duration: Duration(seconds: AppConstants.snackBarTime),
                          ),
                        );
                      } else if (controller.rStatus.isError) {
                        Get.back();
                        showError(context, controller.rStatus.errorMessage ?? '', () {});
                      }
                    });
                  }
                },
                child: Text(
                  Get.arguments['order_type'] == OrderType.newOrder ? '${AppStrings.receiveOrder} ${controller.total} د.ك'
                  :
                  Get.arguments['order_type'] == OrderType.currentOrder ? '${AppStrings.completeOrder} ${controller.total} د.ك'
                      :
                  '${controller.total} د.ك',
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
