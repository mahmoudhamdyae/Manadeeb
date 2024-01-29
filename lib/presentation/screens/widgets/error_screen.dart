import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';

class ErrorScreen extends StatelessWidget {

  final String error;
  const ErrorScreen({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              ImageAssets.error,
              height: AppSize.s190,
            ),
            const SizedBox(height: AppSize.s40,),
            Text(
              error.replaceFirst('Exception: ', ''),
              style: getLargeStyle(
                color: ColorManager.error,
              ),
            ),
          ],
        )
    );
  }
}
