import 'package:flutter/material.dart';

import '../../../resources/strings_manager.dart';
import '../../widgets/top_bar.dart';

class AddOrderScreen extends StatelessWidget {
  const AddOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        children: [
          TopBar(title: AppStrings.addOrderTitle),
        ],
      ),
    );
  }
}
