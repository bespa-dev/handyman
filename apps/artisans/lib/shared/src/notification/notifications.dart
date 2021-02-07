import 'dart:async';
import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handyman/app/routes/routes.gr.dart';
import 'package:handyman/shared/shared.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/subjects.dart';

/// channel & ids
const String conversationChannelId = 'conversation_channel_id';
const String conversationChannelName = 'Conversations';
const String conversationChannelDesc = 'For all end-to-end conversations';
const String bookingChannelId = 'booking_channel_id';
const String bookingChannelName = 'Job Booking';
const String bookingChannelDesc = 'For all job bookings';
const String tokenChannelId = 'token_channel_id';
const String tokenChannelName = 'Device Token';
const String tokenChannelDesc = 'New sign in detection for different devices';
const String approvalChannelId = 'approval_channel_id';
const String approvalChannelName = 'Account Approval';
const String approvalChannelDesc = 'Artisan account approval';

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

  /// setup local notifications
  Future<void> setupNotifications() async {
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
    FirebaseMessaging.onMessageOpenedApp.listen((event) async {
      var container = ProviderContainer();
      final prefs = await container.read(sharedPreferencesProvider.future);
      var prefsRepo = container.read(prefsRepositoryProvider(prefs));
      var datasource = container.read(remoteDatasourceProvider(prefsRepo));
      var navigator = ExtendedNavigator.root;
      var data = event.data;

      /// nav to appropriate screen
      if (data['type'] == 'booking') {
        var user = await datasource.getCustomerById(id: data['customer']);
        var booking = await datasource.getBookingById(id: data['id']).first;
        return navigator.pushBookingDetailsPage(
          customer: user,
          booking: booking,
          bookingId: data['id'],
        );
      } else if (data['type'] == 'conversation') {
        var user = await datasource.getCustomerById(id: data['sender']);
        return navigator.pushConversationPage(
          recipientId: data['sender'],
          recipient: user,
        );
      } else if (data['type'] == 'token') {
      } else if (data['type'] == 'approval') {}
    });

    /// background message handler
    FirebaseMessaging.onBackgroundMessage((rm) async {
      logger.i('onBackground -> $rm');

      var data = rm.data;
      var id = data['type'] == 'booking'
          ? bookingChannelId
          : data['type'] == 'conversation'
              ? conversationChannelId
              : tokenChannelId;

      var name = data['type'] == 'booking'
          ? bookingChannelName
          : data['type'] == 'conversation'
              ? conversationChannelName
              : tokenChannelName;

      var desc = data['type'] == 'booking'
          ? bookingChannelDesc
          : data['type'] == 'conversation'
              ? conversationChannelDesc
              : tokenChannelDesc;

      await _pushNotification(
        data,
        channelId: id,
        channelName: name,
        channelDesc: desc,
      );
    });
    FirebaseMessaging.onMessage.listen((event) async {
      var data = event.data;

      logger.i('onMessage -> $data');
      var id = data['type'] == 'booking'
          ? bookingChannelId
          : data['type'] == 'conversation'
              ? conversationChannelId
              : data['type'] == 'token'
                  ? tokenChannelId
                  : approvalChannelId;

      var name = data['type'] == 'booking'
          ? bookingChannelName
          : data['type'] == 'conversation'
              ? conversationChannelName
              : data['type'] == 'token'
                  ? tokenChannelName
                  : approvalChannelName;

      var desc = data['type'] == 'booking'
          ? bookingChannelDesc
          : data['type'] == 'conversation'
              ? conversationChannelDesc
              : data['type'] == 'token'
                  ? tokenChannelDesc
                  : approvalChannelDesc;
      await _pushNotification(
        data,
        channelId: id,
        channelName: name,
        channelDesc: desc,
      );
    });

    _requestPermissions();
    _configureDidReceiveLocalNotificationSubject();
    _configureSelectNotificationSubject();

    /// fixme -> register notification channels
    await _pushNotification(
      {
        'title': kAppName,
        'body': kLoremText,
      },
      channelId: conversationChannelId,
      channelName: conversationChannelName,
      channelDesc: conversationChannelDesc,
    );
    await _pushNotification(
      {
        'title': kAppName,
        'body': kLoremText,
      },
      channelId: bookingChannelId,
      channelName: bookingChannelName,
      channelDesc: bookingChannelDesc,
    );
    await _pushNotification(
      {
        'title': kAppName,
        'body': kLoremText,
      },
      channelId: tokenChannelId,
      channelName: tokenChannelName,
      channelDesc: tokenChannelDesc,
    );
    await _pushNotification(
      {
        'title': kAppName,
        'body': kLoremText,
      },
      channelId: approvalChannelId,
      channelName: approvalChannelName,
      channelDesc: approvalChannelDesc,
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
    });
  }

  /// close all observers
  void dispose() {
    _didReceiveLocalNotificationSubject.close();
    _selectNotificationSubject.close();
  }
}

/// send push notification
Future<void> _pushNotification(
  Map<String, dynamic> notification, {
  @required String channelId,
  @required String channelName,
  @required String channelDesc,
}) async {
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
    channelId,
    channelName,
    channelDesc,
    channelShowBadge: true,
    channelAction: AndroidNotificationChannelAction.createIfNotExists,
    enableVibration: true,
    importance: Importance.max,
    priority: Priority.high,
    ticker: 'ticker',
  );

  await _plugin.show(
    Random().nextInt(9999),
    notification['title'],
    notification['body'],
    NotificationDetails(android: androidPlatformChannelSpecifics),
  );
}
