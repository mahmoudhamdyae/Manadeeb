import 'package:flutter/cupertino.dart';
import 'package:manadeeb/presentation/resources/styles_manager.dart';

import '../../../../domain/models/order_details.dart';
import '../../../resources/color_manager.dart';

class PackagesListView extends StatelessWidget {

  final List<Orderdetails> orderDetails;
  const PackagesListView({super.key, required this.orderDetails});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: orderDetails[0].package == null ? 0 : 100,
      child: ListView.builder(
        itemCount: orderDetails[0].package == null ? 0 : orderDetails.length,
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(16.0)),
              border: Border.all(
                color: ColorManager.lightGrey,
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      orderDetails[index].package?['name'] ?? '',
                      style: getLargeStyle(),
                    ),
                    const SizedBox(width: 16.0,),
                    Text(
                      '${orderDetails[index].package?['price'] ?? ''} د.ك',
                      style: getLargeStyle(
                        color: ColorManager.secondary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8.0,),
                Text(
                  orderDetails[index].package?['description'] ?? '',
                  style: getSmallStyle(
                    color: ColorManager.grey
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
