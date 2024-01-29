import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manadeeb/presentation/screens/order_details/controller/order_details_controller.dart';
import 'package:manadeeb/presentation/screens/order_details/widgets/order_details_screen_body.dart';

import '../../../resources/strings_manager.dart';
import '../../widgets/error_screen.dart';
import '../../widgets/loading_screen.dart';
import '../../widgets/top_bar.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        children: [
          const TopBar(title: AppStrings.orderDetailsTopBarTitle),
          GetX<OrderDetailsController>(
            init: Get.find<OrderDetailsController>(),
            builder: (OrderDetailsController controller) {
              if (controller.status.isLoading) {
                return const LoadingScreen();
              } else if (controller.status.isError) {
                return ErrorScreen(error: controller.status.errorMessage ?? '');
              }
              return OrderDetailsScreenBody(order: controller.order.value);
            },
          )
        ],
      ),
    );
  }
}
