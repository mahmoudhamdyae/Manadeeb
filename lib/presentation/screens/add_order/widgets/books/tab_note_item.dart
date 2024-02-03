import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manadeeb/presentation/resources/color_manager.dart';
import 'package:manadeeb/presentation/resources/styles_manager.dart';
import 'package:manadeeb/presentation/screens/add_order/controller/add_order_controller.dart';
import 'package:manadeeb/presentation/screens/add_order/widgets/books/notes_quantity_widget.dart';

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
              onChanged: (isSelected) => controller.checkNote(index, isSelected ?? false),
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
            Expanded(child: Container()),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: NotesQuantityWidget(index: index),
            )
          ],
        );
      },
    );
  }
}
