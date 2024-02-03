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

import '../../../../../core/utils/insets.dart';
import '../../../../../domain/models/order_response.dart';
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
              isWide(context) ? _buildTwoColumn(controller) : _buildOneColumn(controller),
            ],);
          },
      ),
    );
  }
}

Widget _buildOneColumn(NewOrdersController controller) {
  return ListView(
    shrinkWrap: true,
    physics: const ClampingScrollPhysics(),
    children: [
      _buildCities(controller.cities),
      const SizedBox(height: 8.0,),
      _buildItems(controller.status, controller.orders),
    ],
  );
}

Widget _buildTwoColumn(NewOrdersController controller) {
  return Row(
    children: [
      Expanded(
        flex: 1,
        child: _buildCities(controller.cities),
      ),
      const SizedBox(width: 8.0,),
      Expanded(
        flex: 2,
        child: _buildItems(controller.status, controller.orders),
      ),
    ],
  );
}

Widget _buildCities(List<City> cities) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 32.0),
    child: ListView.separated(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemCount: cities.length,
      itemBuilder: (BuildContext context, int index) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${AppStrings.city} ${cities[index].name ?? ''}',
              style: getLargeStyle(),
            ),
            Text(
              'سعر التوصيل ${cities[index].deliverPrice ?? 0} د.ك',
              style: getSmallStyle(
                color: ColorManager.secondary,
              ),
            ),
          ],
        );
      }, separatorBuilder: (BuildContext context, int index) {
      return const SizedBox(height: 8.0,);
    },
    ),
  );
}

Widget _buildItems(RxStatus status, List<Order> orders) {
  return status.isLoading ? const LoadingScreen() :
  status.isError ? ErrorScreen(error: status.errorMessage ?? '') :
  orders.isEmpty ? const EmptyScreen(emptyString: AppStrings.emptyOrders) :
  OrdersList(orders: orders, orderType: OrderType.newOrder,);
}
