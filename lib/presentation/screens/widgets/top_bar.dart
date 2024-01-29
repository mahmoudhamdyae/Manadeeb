import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../resources/color_manager.dart';
import '../../resources/styles_manager.dart';

class TopBar extends StatelessWidget {

  final String title;
  const TopBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Icon(
                Icons.arrow_back_ios,
                color: ColorManager.black,
              ),
            )
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 64.0),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: getLargeStyle(),
            ),
          ),
        ),
      ],
    );
  }
}
