import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manadeeb/presentation/resources/strings_manager.dart';
import 'package:manadeeb/presentation/screens/home/controller/home_controller.dart';
import 'package:manadeeb/presentation/screens/home/widgets/orders_list.dart';
import 'package:manadeeb/presentation/screens/widgets/empty_screen.dart';
import 'package:manadeeb/presentation/screens/widgets/error_screen.dart';
import 'package:manadeeb/presentation/screens/widgets/home_app_bar/home_app_bar.dart';
import 'package:manadeeb/presentation/screens/widgets/loading_screen.dart';

class HomeScreen extends StatelessWidget {

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        children: [
          HomeAppBar(),
          GetX<HomeController>(
            init: Get.find<HomeController>(),
            builder: (HomeController controller) {
              if (controller.status.isLoading) {
                return const LoadingScreen();
              } else if (controller.status.isError) {
                return const ErrorScreen(error: AppStrings.error);
              } else if (controller.orders.isEmpty) {
                return const EmptyScreen(emptyString: AppStrings.emptyOrders);
              }
              return OrdersList(orders: controller.orders,);
              },
          )
        ],
      ),
    );
  }
}
