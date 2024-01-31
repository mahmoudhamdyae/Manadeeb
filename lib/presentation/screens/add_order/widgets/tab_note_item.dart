import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manadeeb/domain/models/notes_and_packages.dart';
import 'package:manadeeb/presentation/resources/color_manager.dart';
import 'package:manadeeb/presentation/resources/styles_manager.dart';
import 'package:manadeeb/presentation/screens/add_order/controller/add_order_controller.dart';

class TabNoteItem extends StatelessWidget {

  final int index;
  const TabNoteItem({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return GetX<AddOrderController>(
      init: Get.find<AddOrderController>(),
      builder: (AddOrderController controller) {
        return Row(
          children: [
            Checkbox(
              value: controller.checkedBooks[index],
              onChanged: (isSelected) => controller.checkNote(index),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  controller.books[index].name ?? '',
                  style: getLargeStyle(),
                ),
                const SizedBox(height: 8.0,),
                Text(
                  controller.books[index].classroom ?? '',
                  style: getSmallStyle(
                      color: ColorManager.grey
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
