import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manadeeb/domain/models/order_type.dart';

import '../../../../resources/strings_manager.dart';
import '../../../widgets/empty_screen.dart';
import '../../../widgets/error_screen.dart';
import '../../../widgets/home_app_bar/home_app_bar.dart';
import '../../../widgets/loading_screen.dart';
import '../../../widgets/order/orders_list.dart';
import '../controller/current_orders_controller.dart';

class CurrentOrderScreen extends StatelessWidget {
  const CurrentOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetX<CurrentOrdersController>(
        init: Get.find<CurrentOrdersController>(),
        builder: (CurrentOrdersController controller) {
          return ListView(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            children: [
              HomeAppBar(),
              controller.status.isLoading ? const LoadingScreen() :
              controller.status.isError ? ErrorScreen(error: controller.status.errorMessage ?? '') :
              controller.orders.isEmpty ? const EmptyScreen(emptyString: AppStrings.emptyOrders) :
              OrdersList(orders: controller.orders, orderType: OrderType.currentOrder,),
            ],);
        },
      ),
    );
  }
}
