import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:manadeeb/presentation/resources/styles_manager.dart';

import '../../../resources/color_manager.dart';
import '../controller/order_details_controller.dart';

class PackagesListView extends StatelessWidget {

  const PackagesListView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<OrderDetailsController>(
        init: Get.find<OrderDetailsController>(),
        builder: (OrderDetailsController controller) {
          return ListView.builder(
            itemCount: controller.packageNo.value,
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          controller.packages[index]['name'] ?? '',
                          style: getLargeStyle(),
                        ),
                        Text(
                          '${controller.packages[index]['price'] ?? ''} د.ك',
                          style: getLargeStyle(
                            color: ColorManager.secondary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          controller.packages[index]['class'] ?? '',
                          style: getSmallStyle(
                              color: ColorManager.grey
                          ),
                        ),
                        Text(
                          'الكمية: ${(controller.order.value.orderdetails?[index].quantity ?? 0)}',
                          style: getSmallStyle(
                              color: ColorManager.grey
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
    },
    );
  }
}
