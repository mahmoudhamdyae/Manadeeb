import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    // Initialize native android notification
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/launcher_icon');

    // Initialize native Ios Notifications
    const DarwinInitializationSettings initializationSettingsIOS =
    DarwinInitializationSettings();

    const InitializationSettings initializationSettings =
    InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
  }

  void showNotification(String title, String value) async {
    const AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails('1', 'New Orders',
        channelDescription: 'New orders from students',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker');

    DarwinNotificationDetails iOSPlatformChannelSpecifics =
    DarwinNotificationDetails(
        presentAlert: false,  // Present an alert when the notification is displayed and the application is in the foreground (only from iOS 10 onwards)
        presentBadge: true,  // Present the badge number when the notification is displayed and the application is in the foreground (only from iOS 10 onwards)
        presentSound: true,  // Play a sound when the notification is displayed and the application is in the foreground (only from iOS 10 onwards)
        sound: '',  // Specifics the file path to play (only from iOS 10 onwards)
        badgeNumber: 1, // The application's icon badge number
        attachments: <DarwinNotificationAttachment>[],// (only from iOS 10 onwards)
        subtitle: value, //Secondary description  (only from iOS 10 onwards)
        threadIdentifier: '' // (only from iOS 10 onwards)
    );

    int notificationId = 1;
    NotificationDetails notificationDetails =
    NotificationDetails(
      android: androidNotificationDetails,
      iOS: iOSPlatformChannelSpecifics
    );

    await flutterLocalNotificationsPlugin
        .show(notificationId, title, value, notificationDetails, payload: 'Not present');
  }
}