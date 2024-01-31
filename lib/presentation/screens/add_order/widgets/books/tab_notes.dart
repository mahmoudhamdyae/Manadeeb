import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:manadeeb/domain/models/notes_and_packages.dart';
import 'package:manadeeb/presentation/resources/strings_manager.dart';
import 'package:manadeeb/presentation/screens/add_order/controller/add_order_controller.dart';
import 'package:manadeeb/presentation/screens/add_order/widgets/books/tab_note_item.dart';
import 'package:manadeeb/presentation/screens/widgets/empty_screen.dart';
import 'package:manadeeb/presentation/screens/widgets/error_screen.dart';
import 'package:manadeeb/presentation/screens/widgets/loading_screen.dart';

import '../../../../resources/color_manager.dart';

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
        return ListView.builder(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          itemCount: controller.books.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
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
            );
          },
        );
      },
    );
  }
}
