import 'package:flutter/material.dart';

import '../../../core/launch_site.dart';
import '../../resources/font_manager.dart';
import '../../resources/strings_manager.dart';
import '../../resources/styles_manager.dart';

class CodingSiteWidget extends StatelessWidget {
  const CodingSiteWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        launchSite('https://coding-site.com/');
      },
      child: Text(
        AppStrings.madeBy,
        style: getLargeStyle(
          fontSize: FontSize.s18,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
