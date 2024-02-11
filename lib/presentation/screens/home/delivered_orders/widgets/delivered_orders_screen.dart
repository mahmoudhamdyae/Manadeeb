import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manadeeb/domain/models/order_type.dart';
import 'package:manadeeb/presentation/resources/styles_manager.dart';

import '../../../../resources/color_manager.dart';
import '../../../../resources/strings_manager.dart';
import '../../../widgets/empty_screen.dart';
import '../../../widgets/error_screen.dart';
import '../../../widgets/home_app_bar/home_app_bar.dart';
import '../../../widgets/loading_screen.dart';
import '../../../widgets/order/orders_list.dart';
import '../controller/delivered_orders_controller.dart';

class DeliveredOrdersScreen extends StatelessWidget {
  const DeliveredOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetX<DeliveredOrdersController>(
        init: Get.find<DeliveredOrdersController>(),
        builder: (DeliveredOrdersController controller) {
          return ListView(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            children: [
              HomeAppBar(),
              controller.status.isLoading ? const LoadingScreen() :
              controller.status.isError ? ErrorScreen(error: controller.status.errorMessage ?? '') :
              controller.orders.isEmpty ? const EmptyScreen(emptyString: AppStrings.emptyOrders) :
              ListView(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                children: [
                  const SizedBox(height: 8.0,),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                            children: [
                              Text(
                                AppStrings.ordersTotal,
                                style: getLargeStyle(),
                              ),
                              Text(
                                '90 د.ك',
                                style: getSmallStyle(),
                              ),
                            ]
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              AppStrings.deliverTotal,
                              style: getLargeStyle(),
                            ),
                            Text(
                            '10 د.ك',
                              style: getSmallStyle(),
                            ),
                          ]
                        ),
                      ),
                      Expanded(
                        child: Column(
                            children: [
                              Text(
                                AppStrings.total,
                                style: getLargeStyle(),
                              ),
                              Text(
                                '100 د.ك',
                                style: getSmallStyle(),
                              ),
                            ]
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0,),
                  OrdersList(orders: controller.orders, orderType: OrderType.completeOrder,)
                ],
              ),
            ],);
        },
      ),
    );
  }
}
