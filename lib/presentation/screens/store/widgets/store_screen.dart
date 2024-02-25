import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manadeeb/core/utils/insets.dart';
import 'package:manadeeb/domain/models/note.dart';
import 'package:manadeeb/presentation/resources/color_manager.dart';
import 'package:manadeeb/presentation/resources/strings_manager.dart';
import 'package:manadeeb/presentation/resources/styles_manager.dart';
import 'package:manadeeb/presentation/screens/store/controller/store_controller.dart';
import 'package:manadeeb/presentation/screens/widgets/dialogs/error_dialog.dart';
import 'package:manadeeb/presentation/screens/widgets/dialogs/loading_dialog.dart';
import 'package:manadeeb/presentation/screens/widgets/empty_screen.dart';
import 'package:manadeeb/presentation/screens/widgets/error_screen.dart';
import 'package:manadeeb/presentation/screens/widgets/loading_screen.dart';
import 'package:manadeeb/presentation/screens/widgets/top_bar.dart';

import '../../../resources/constants_manager.dart';

class StoreScreen extends StatelessWidget {

  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          StoreController controller = Get.find<StoreController>();
          await controller.getAllNotes(controller.sfoof[controller.selected.value]);
          },
        child: ListView(
          shrinkWrap: true,
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            const TopBar(title: AppStrings.storeTitle),
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: Get.find<StoreController>().getSfoofLength(),
                itemBuilder: (BuildContext context, int index) {
                  return GetX<StoreController>(
                    init: Get.find<StoreController>(),
                    builder: (StoreController controller) {
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
            GetX<StoreController>(
              init: Get.find<StoreController>(),
              builder: (StoreController controller) {
                List<MandubBooks> books = controller.filteredNotes;
                if (controller.status.isLoading) {
                  return const LoadingScreen();
                } else if (controller.status.isError) {
                  return ErrorScreen(error: controller.status.errorMessage ?? '');
                } else if (books.isEmpty) {
                  return const EmptyScreen(emptyString: AppStrings.noNotes);
                }
                return isWide(context) ? _buildTwoColumn(context, controller)
                    :
                _buildOneColumn(controller);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOneColumn(StoreController controller) {
    return ListView.builder(
      itemCount: controller.filteredNotes.length,
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return _buildItem(context, controller, index);
      },
    );
  }

  Widget _buildTwoColumn(BuildContext context, StoreController controller) {
    return GridView.count(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      crossAxisCount:(MediaQuery.of(context).size.width ~/ 210).toInt(),
      childAspectRatio: 1.8,
      children: List.generate(controller.filteredNotes.length, (index) {
        return _buildItem(context, controller, index);
      }),
    );
  }

  Widget _buildItem(BuildContext context, StoreController controller, int index) {
    List<MandubBooks> books = controller.filteredNotes;
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
                books[index].name ?? '',
                style: getLargeStyle(),
              ),
              Text(
                '${books[index].bookPrice} د.ك',
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
                books[index].classroom ?? '',
                style: getSmallStyle(
                    color: ColorManager.grey
                ),
              ),
              Text(
                '${AppStrings.quantity}: ${books[index].pivot?.mandubQuantity ?? 0}',
                style: getSmallStyle(
                    color: ColorManager.grey
                ),
              ),
            ],
          ),
          books[index].pivot?.mandubActive != 0 ? Container() : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
            child: SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                style: getOutlinedButtonStyle(),
                onPressed: () {
                  showLoading(context);
                  controller.tawreed(books[index].id ?? -1, index).then((value) {
                    if (controller.tawreedStatus.isError) {
                      Get.back();
                      showError(context, controller.tawreedStatus.errorMessage ?? '', () {});
                    } else {
                      Get.back();
                      Get.showSnackbar(
                        const GetSnackBar(
                          title: null,
                          message: AppStrings.successDialogTitle,
                          icon: Icon(Icons.done, color: ColorManager.white,),
                          duration: Duration(seconds: AppConstants.snackBarTime),
                        ),
                      );
                      books[index].pivot?.station = 0;
                    }
                  });
                },
                child: Text(
                  AppStrings.stationButton,
                  style: getSmallStyle(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
