import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manadeeb/core/utils/insets.dart';
import 'package:manadeeb/presentation/resources/strings_manager.dart';
import 'package:manadeeb/presentation/screens/add_order/controller/add_order_controller.dart';
import 'package:manadeeb/presentation/screens/add_order/widgets/books/tab_note_item.dart';
import 'package:manadeeb/presentation/screens/widgets/empty_screen.dart';
import 'package:manadeeb/presentation/screens/widgets/error_screen.dart';
import 'package:manadeeb/presentation/screens/widgets/loading_screen.dart';

import '../../../../resources/color_manager.dart';
import '../../../../resources/styles_manager.dart';

class TabNotes extends StatelessWidget {
  const TabNotes({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<AddOrderController>(
      init: Get.find<AddOrderController>(),
      builder: (AddOrderController controller) {
        if (controller.status.isLoading) {
          return const LoadingScreen();
        } else if (controller.status.isError) {
          return ErrorScreen(error: controller.status.errorMessage ?? '');
        } else if (controller.books.isEmpty) {
          return const EmptyScreen(emptyString: AppStrings.noNotes);
        }
        return Column(
          children: [
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: Get.find<AddOrderController>().getSfoofLength(),
                itemBuilder: (BuildContext context, int index) {
                  return GetX<AddOrderController>(
                    init: Get.find<AddOrderController>(),
                    builder: (AddOrderController controller) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                          onTap: () => controller.select(index) ,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                              border: Border.all(
                                color: controller.isSelected(index) ? ColorManager.grey : ColorManager.lightGrey,
                              ),
                              color: controller.isSelected(index) ? ColorManager.lightGrey : ColorManager.white,
                            ),
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              controller.sfoof[index],
                              style: getSmallStyle(),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
        controller.filteredNotes.isEmpty ?
        const EmptyScreen(emptyString: AppStrings.noNotes)
            :
            Column(
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: controller.getValueOfSelectAllNotes(),
                      onChanged: (isSelected) => controller.selectAllNotes(isSelected ?? false),
                    ),
                    Text(
                      AppStrings.selectAll,
                      style: getLargeStyle(),
                    ),
                  ],
                ),
                isWide(context) ? _buildOneColumn(controller)//_buildTwoColumn(context, controller)
                    :
                _buildOneColumn(controller),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildTwoColumn(BuildContext context, AddOrderController controller) {
    return GridView.count(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      crossAxisCount:(MediaQuery.of(context).size.width ~/ 210).toInt(),
      childAspectRatio: 1.8,
      children: List.generate(controller.books.length, (index) {
        return _buildItem(controller, index);
      }),
    );
  }

  Widget _buildOneColumn(AddOrderController controller) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemCount: controller.books.length,
      itemBuilder: (BuildContext context, int index) {
        return _buildItem(controller, index);
      },
    );
  }

  Widget _buildItem(AddOrderController controller, int index) {
    return controller.isBookInList(index) ? Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(16.0)),
        border: Border.all(
          color: ColorManager.lightGrey,
          width: 1,
        ),
      ),
      child: TabNoteItem(index: index,),
    ) : Container();
  }
}
