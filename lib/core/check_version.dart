import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../presentation/resources/strings_manager.dart';
import '../presentation/resources/styles_manager.dart';
import 'constants.dart';
import 'launch_site.dart';

versionCheck(context) async {
  // Get Current installed version of app
  final PackageInfo info = await PackageInfo.fromPlatform();
  double currentVersion = double.parse(info.version.trim().replaceAll(".", ""));

  // Get Latest version info from firebase config
  final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
  await remoteConfig.setConfigSettings(RemoteConfigSettings(
    fetchTimeout: const Duration(),
    minimumFetchInterval: const Duration(),
  ));

  try {
    // Using default duration to force fetching from remote server.
    await remoteConfig.fetch();
    await remoteConfig.activate();
    String forceUpdateCurrentVersion = remoteConfig.getString('manadeeb_force_update_current_version');
    double newVersion = double.parse(forceUpdateCurrentVersion
        .trim()
        .replaceAll(".", ""));
    debugPrint('--------------------- remote $newVersion');
    debugPrint('--------------------- current $currentVersion');
    if (newVersion > currentVersion) {
      _showVersionDialog(context);
    }
  } on Exception catch (exception) {
    // Fetch throttled.
    debugPrint(exception.toString());
  } catch (exception) {
    debugPrint('Unable to fetch remote config. Cached or default values will be used');
  }
}

_showVersionDialog(context) async {
  await showDialog<String>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      String title = AppStrings.updateDialogTitle;
      String message = AppStrings.updateDialogMessage;
      String btnLabel = AppStrings.updateDialogButtonLabel;
      String btnLabelCancel = AppStrings.updateDialogButtonLabelCancel;
      return AlertDialog(
        title: Text(
          title,
          style: getLargeStyle(),
        ),
        content: Text(
          message,
          style: getSmallStyle(),
        ),
        actions: [
          MaterialButton(
            child: Text(
              btnLabel,
              style: getLargeStyle(),
            ),
            onPressed: () => GetPlatform.isAndroid ?
            launchSite(Constants.playStoreUrl)
                :
            launchSite(Constants.appStoreUrl),
          ),
          MaterialButton(
            child: Text(
              btnLabelCancel,
              style: getSmallStyle(),
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      );
    },
  );
}