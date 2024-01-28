import 'package:flutter/material.dart';

import '../../../resources/strings_manager.dart';
import '../../../resources/values_manager.dart';

showError(BuildContext context, String message, Function retryAction) {
  return showDialog(context: context, builder: (BuildContext context) {
    return AlertDialog(
      // The shape of the dialog
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(AppSize.s20)),
      ),
      // The title of the dialog
      title: const Text(AppStrings.errorDialogTitle),
      // The content of the dialog
      content: Text(message.replaceFirst('Exception: ', '')),
      // The actions of the dialog
      actions: [
        // A button to cancel the operation
        TextButton(
          onPressed: () {
            // Close the dialog
            Navigator.of(context).pop();
          },
          child: const Text(AppStrings.cancel),
        ),
        // A button to retry the operation
        TextButton(
          onPressed: () {
            // Close the dialog
            Navigator.of(context).pop();
            // Retry the operation
            retryAction();
          },
          child: const Text(AppStrings.retryAgain),
        ),
      ],
    );
  }
  );
}