import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manadeeb/domain/models/order_type.dart';
import 'package:manadeeb/presentation/resources/color_manager.dart';
import 'package:manadeeb/presentation/resources/strings_manager.dart';
import 'package:manadeeb/presentation/resources/styles_manager.dart';
import 'package:manadeeb/presentation/screens/widgets/empty_screen.dart';
import 'package:manadeeb/presentation/screens/widgets/error_screen.dart';
import 'package:manadeeb/presentation/screens/widgets/home_app_bar/home_app_bar.dart';
import 'package:manadeeb/presentation/screens/widgets/loading_screen.dart';

import '../../../widgets/order/orders_list.dart';
import '../controller/new_orders_controller.dart';

class NewOrdersScreen extends StatelessWidget {

  const NewOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetX<NewOrdersController>(
        init: Get.find<NewOrdersController>(),
        builder: (NewOrdersController controller) {
          return ListView(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            children: [
              HomeAppBar(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${AppStrings.city} ${controller.city.value.name ?? ''}',
                      style: getLargeStyle(),
                    ),
                    Text(
                      'سعر التوصيل ${controller.city.value.deliverPrice ?? 0} د.ك',
                      style: getSmallStyle(
                        color: ColorManager.secondary,
                      ),
                    ),
                  ],
                ),
              ),
              controller.status.isLoading ? const LoadingScreen() :
              controller.status.isError ? ErrorScreen(error: controller.status.errorMessage ?? '') :
              controller.orders.isEmpty ? const EmptyScreen(emptyString: AppStrings.emptyOrders) :
              OrdersList(orders: controller.orders, orderType: OrderType.newOrder,),
            ],);
          },
      ),
    );
  }
}
