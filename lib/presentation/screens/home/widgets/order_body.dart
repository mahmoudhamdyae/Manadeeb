import 'package:flutter/cupertino.dart';
import 'package:manadeeb/domain/models/order.dart';
import 'package:manadeeb/presentation/resources/color_manager.dart';
import 'package:manadeeb/presentation/resources/styles_manager.dart';

class OrderBody extends StatelessWidget {

  final Order order;
  const OrderBody({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Text(
              order.buyer ?? '',
              style: getLargeStyle(),
            ),
            const SizedBox(height: 8.0,),
            Text(
              order.phone ?? '',
              style: getSmallStyle(
                color: ColorManager.grey,
              ),
            ),
          ],
        ),
        Column(
          children: [
            Text(
              '${order.priceAll ?? ''} د.ك',
              style: getLargeStyle(
                color: ColorManager.secondary,
              ),
            ),
            const SizedBox(height: 8.0,),
            Text(
              order.address ?? '',
              style: getSmallStyle(
                color: ColorManager.grey,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
