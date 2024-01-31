import 'package:flutter/material.dart';
import 'package:manadeeb/presentation/screens/add_order/widgets/tab_notes.dart';
import 'package:manadeeb/presentation/screens/add_order/widgets/tab_packages.dart';

import '../../../resources/color_manager.dart';
import '../../../resources/strings_manager.dart';
import '../../../resources/styles_manager.dart';

class AddOrderTabs extends StatefulWidget {

  const AddOrderTabs({super.key});

  @override
  State<AddOrderTabs> createState() => _CourseTabsState();
}

class _CourseTabsState extends State<AddOrderTabs> {

  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              Expanded(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        selectedTab = 0;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        AppStrings.addOrderTabNotes,
                        style: getLargeStyle(),
                      ),
                    ),
                  )
              ),
              Expanded(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        selectedTab = 1;
                      });
                    },
                    child: Center(
                      child: Text(
                        AppStrings.addOrderTabPackages,
                        style: getLargeStyle(),
                      ),
                    ),
                  )
              ),
            ],
          ),
        ),
        Stack(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Divider(),
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: selectedTab == 0 ? const Divider(
                      color: ColorManager.primary,
                      thickness: 3,
                    ) : Container(),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: selectedTab == 1 ? const Divider(
                      color: ColorManager.primary,
                      thickness: 3,
                    ) : Container(),
                  ),
                ),
              ],
            ),
          ],
        ),
        selectedTab == 0 ? const TabNotes() :
        const TabPackages(),
      ],
    );
  }
}
