import 'package:flutter/material.dart';

import '../../../resources/strings_manager.dart';
import '../../../resources/values_manager.dart';

showLoading(BuildContext context) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return const AlertDialog(
          // The shape of the dialog
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          // The content of the dialog
          title: Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // The loading indicator
                CircularProgressIndicator(),
                SizedBox(
                  height: AppSize.s16,
                ),
                // Some text
                Text(AppStrings.loading)
              ],
            ),
          ),
        );
      }
  );
}