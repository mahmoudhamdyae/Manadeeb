import 'package:flutter/material.dart';

import '../../../resources/strings_manager.dart';
import '../../widgets/top_bar.dart';
import 'add_order_tabs.dart';

class AddOrderScreen extends StatelessWidget {
  const AddOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        children: const [
          TopBar(title: AppStrings.addOrderTitle),
          AddOrderTabs(),
        ],
      ),
    );
  }
}
