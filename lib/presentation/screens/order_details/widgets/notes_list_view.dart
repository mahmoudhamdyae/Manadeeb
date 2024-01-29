import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../resources/color_manager.dart';
import '../../../resources/styles_manager.dart';
import '../controller/order_details_controller.dart';

class NotesListView extends StatelessWidget {

  const NotesListView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<OrderDetailsController>(
        init: Get.find<OrderDetailsController>(),
        builder: (OrderDetailsController controller) {
          return ListView.builder(
            itemCount: controller.bookNo.value,
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
                          controller.books[index].name ?? '',
                          style: getLargeStyle(),
                        ),
                        Text(
                          '${controller.books[index].bookPrice ?? ''} د.ك',
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
                      controller.books[index].classroom ?? '',
                      style: getSmallStyle(
                          color: ColorManager.grey
                      ),
                    ),
                        Text(
                          'الكمية: ${controller.order.value.orderdetails?[index].quantity ?? 1}',
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
