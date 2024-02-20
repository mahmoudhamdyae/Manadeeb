import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manadeeb/core/utils/insets.dart';
import 'package:manadeeb/domain/models/order_type.dart';
import 'package:manadeeb/presentation/screens/order_details/widgets/order_details_screen.dart';

import '../../../../domain/models/order_response.dart';
import '../../../resources/color_manager.dart';
import 'order_body.dart';

class OrdersList extends StatelessWidget {

  final List<Order> orders;
  final List<bool> isOnlineList;
  final OrderType orderType;
  final bool fromNew;
  const OrdersList({super.key, required this.orders, required this.isOnlineList, required this.orderType, this.fromNew = false});

  @override
  Widget build(BuildContext context) {
    return fromNew ? _buildListView(orders, orderType, isOnlineList) : isWide(context) ?
    _buildGridView(context, orders, orderType, isOnlineList)
        :
    _buildListView(orders, orderType, isOnlineList);
  }
}

Widget _buildGridView(BuildContext context, List<Order> orders, OrderType orderType, List<bool> isOnlineList) {
  return GridView.count(
    shrinkWrap: true,
    physics: const ClampingScrollPhysics(),
    crossAxisCount:(MediaQuery.of(context).size.width ~/ 350).toInt(),
    childAspectRatio: 2.2,
    children: List.generate(orders.length, (index) {
      return _buildItem(orders[index], orderType, index, isOnlineList);
    }),
  );
}

Widget _buildListView(List<Order> orders, OrderType orderType, List<bool> isOnlineList) {
  return ListView.builder(
    shrinkWrap: true,
    physics: const ClampingScrollPhysics(),
    itemCount: orders.length,
    itemBuilder: (BuildContext context, int index) {
      return _buildItem(orders[index], orderType, index, isOnlineList);
    },
  );
}

Widget _buildItem(Order order, OrderType orderType, int index, List<bool> isOnlineList) {
  return InkWell(
    onTap: () =>
      Get.to(() => const OrderDetailsScreen(), arguments: { 'order_id': order.id, 'order_type': orderType, 'city_id': order.cityId }),
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
      child: OrderBody(order: order, isOnline: isOnlineList[index],),
    ),
  );
}
