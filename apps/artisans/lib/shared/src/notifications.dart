import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:handyman/shared/src/constants.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/subjects.dart';

/// notification plugin instance
final FlutterLocalNotificationsPlugin _plugin =
    FlutterLocalNotificationsPlugin();

/// Streams are created so that app can respond to notification-related events
final BehaviorSubject<ReceivedNotification> didReceiveLocalNotificationSubject =
    BehaviorSubject<ReceivedNotification>();

final BehaviorSubject<String> selectNotificationSubject =
    BehaviorSubject<String>();

/// data model for received messages
class ReceivedNotification {
  ReceivedNotification({
    @required this.id,
    @required this.title,
    @required this.body,
    @required this.payload,
  });

  final int id;
  final String title;
  final String body;
  final String payload;
}

/// background message handler
Future<void> onBackgroundMessageHandler(Map<String, dynamic> message) async {
  logger.i('onBackground -> $message');
}

/// setup local notifications
Future<void> setupNotifications() async {
  final notificationAppLaunchDetails =
      await _plugin.getNotificationAppLaunchDetails();

  const initializationSettingsAndroid =
      AndroidInitializationSettings('app_logo');

  /// Request permission on iOS
  final initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification:
          (int id, String title, String body, String payload) async {
        didReceiveLocalNotificationSubject.add(ReceivedNotification(
            id: id, title: title, body: body, payload: payload));
      });

  final initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
  );

  await _plugin.initialize(initializationSettings,
      onSelectNotification: (String payload) async {
    if (payload != null) {
      logger.d('notification payload: $payload');
    }
    selectNotificationSubject.add(payload);
  });

  /// setup firebase messaging
  var messaging = FirebaseMessaging();
  messaging.configure(
    onBackgroundMessage: onBackgroundMessageHandler,
    onLaunch: (_) async {
      logger.i('onLaunch -> $_');
    },
    onMessage: (_) async {
      logger.i('onMessage -> $_');
    },
    onResume: (_) async {
      logger.i('onResume -> $_');
    },
  );
}
