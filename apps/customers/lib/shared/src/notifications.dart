import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:lite/shared/shared.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/subjects.dart';
import 'package:timezone/timezone.dart' as tz;

/// channel & ids
const String conversationChannelId = 'conversation_channel_id';
const String conversationChannelName = 'Conversations';
const String conversationChannelDesc = 'For all end-to-end conversations';
const String bookingChannelId = 'booking_channel_id';
const String bookingChannelName = 'Job Booking';
const String bookingChannelDesc = 'For all job bookings';

/// notification plugin instance
final FlutterLocalNotificationsPlugin _plugin =
    FlutterLocalNotificationsPlugin();

/// Streams are created so that app can respond to notification-related events
final BehaviorSubject<ReceivedNotification>
    _didReceiveLocalNotificationSubject =
    BehaviorSubject<ReceivedNotification>();

final BehaviorSubject<String> _selectNotificationSubject =
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

class LocalNotificationService {
  const LocalNotificationService();

  /// background message handler
  static Future<void> _onBackgroundMessageHandler(
      Map<String, dynamic> message) async {
    logger.i('onBackground -> $message');
  }

  /// setup local notifications
  Future<void> setupNotifications() async {
    logger.d('setting up notifications...');
    final notificationAppLaunchDetails =
        await _plugin.getNotificationAppLaunchDetails();

    const initializationSettingsAndroid =
        AndroidInitializationSettings('app_logo');

    /// Request permission on iOS
    final initializationSettingsIOS = IOSInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false,
        onDidReceiveLocalNotification:
            (int id, String title, String body, String payload) async {
          _didReceiveLocalNotificationSubject.add(ReceivedNotification(
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
      _selectNotificationSubject.add(payload);
    });

    /// setup firebase messaging
    var messaging = FirebaseMessaging();
    messaging.configure(
      onBackgroundMessage: _onBackgroundMessageHandler,
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

    _requestPermissions();
    _configureDidReceiveLocalNotificationSubject();
    _configureSelectNotificationSubject();

    await Future.delayed(kTestDuration);
    const androidPlatformChannelSpecifics = AndroidNotificationDetails(
      bookingChannelId,
      bookingChannelName,
      bookingChannelDesc,
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );

    const platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await _plugin.show(
      12,
      kAppName,
      kLoremText,
      // tz.TZDateTime.now(tz.local).add(const Duration(seconds: 2)),
      platformChannelSpecifics,
      payload: 'Hello world',
      // androidAllowWhileIdle: true,
      // uiLocalNotificationDateInterpretation:
      //     UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  Future<void> cancel({bool allNotifications = false, int id}) async {
    if (allNotifications) {
      await _plugin.cancelAll();
    } else if (id != null) await _plugin.cancel(id);
  }

  void _requestPermissions() {
    _plugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  void _configureDidReceiveLocalNotificationSubject() {
    _didReceiveLocalNotificationSubject.stream
        .listen((ReceivedNotification receivedNotification) async {
      logger.d('notification title -> ${receivedNotification.title}');
      logger.d('notification body -> ${receivedNotification.body}');
    });
  }

  void _configureSelectNotificationSubject() {
    _selectNotificationSubject.stream.listen((String payload) async {
      logger.d('Stream from selected notification -> $payload');

      /// todo -> move to page
      return ExtendedNavigator.root.pushServiceRatingsPage();
    });
  }

  /// close all observers
  void dispose() {
    _didReceiveLocalNotificationSubject.close();
    _selectNotificationSubject.close();
  }
}
