import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manadeeb/domain/models/order_type.dart';
import 'package:manadeeb/presentation/screens/order_details/widgets/order_details_screen.dart';

import '../../../../domain/models/order_response.dart';
import '../../../resources/color_manager.dart';
import 'order_body.dart';

class OrdersList extends StatelessWidget {

  final List<Order> orders;
  final OrderType orderType;
  const OrdersList({super.key, required this.orders, required this.orderType});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemCount: orders.length,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {
            Get.to(() => const OrderDetailsScreen(), arguments: { 'order_id': orders[index].id, 'order_type': orderType, 'city_id': orders[index].cityId });
          },
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(16.0)),
              border: Border.all(
                color: ColorManager.lightGrey,
                width: 1,
              ),
            ),
            child: OrderBody(order: orders[index],),
          ),
        );
      },
    );
  }
}
