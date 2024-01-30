import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:manadeeb/presentation/resources/strings_manager.dart';
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
          TopBar(title: AppStrings.storeTitle),
        ],
      ),
    );
  }
}
