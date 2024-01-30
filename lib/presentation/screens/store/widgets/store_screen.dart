import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manadeeb/presentation/resources/color_manager.dart';
import 'package:manadeeb/presentation/resources/strings_manager.dart';
import 'package:manadeeb/presentation/resources/styles_manager.dart';
import 'package:manadeeb/presentation/screens/store/controller/store_controller.dart';
import 'package:manadeeb/presentation/screens/widgets/top_bar.dart';

class StoreScreen extends StatelessWidget {

  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
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
                    return InkWell(
                      onTap: () => controller.select(index) ,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                          border: Border.all(
                            color: controller.isSelected(index) ? ColorManager.grey : ColorManager.lightGrey,
                          ),
                          color: controller.isSelected(index) ? ColorManager.lightGrey : ColorManager.white,
                        ),
                        margin: const EdgeInsets.all(8.0),
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          controller.sfoof[index],
                          style: getSmallStyle(),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
