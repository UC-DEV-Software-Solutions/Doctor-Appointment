import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationsService{
  //create an instance of the flutter local notification plugin
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  static Future<void> onDidReceiveBackgroundNotificationResponse(
      NotificationResponse notificationResponse) async {}

  //initialize the notification
  static Future<void> init() async {
    //initialize the android settings
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/launcher_icon');

    //initialize the ios settings
    const DarwinInitializationSettings initializationSettingsIos =
    DarwinInitializationSettings();

    //combine the android and ios settings
    const InitializationSettings initializationSettings =
    InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIos,
    );

    //initialize the plugin
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveBackgroundNotificationResponse:
      onDidReceiveBackgroundNotificationResponse,
      onDidReceiveNotificationResponse:
      onDidReceiveBackgroundNotificationResponse,
    );

    //request permission to show notifications android
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  //show a notification (instant notification)
  static Future<void> showInstantNotification(
      {required String title, required String body}) async {
    //define the notification details
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      //define the android notification details
      android: AndroidNotificationDetails(
        "channel_Id",
        "channel_Name",
        importance: Importance.max,
        priority: Priority.high,
      ),

      //define the ios notification details
      iOS: DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      ),
    );

    //show the notification
    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
    );
  }
}