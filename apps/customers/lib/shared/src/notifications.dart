import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:lite/shared/shared.dart';
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

/// notification plugin instance
final FlutterLocalNotificationsPlugin _plugin =
    FlutterLocalNotificationsPlugin();

/// Streams are created so that app can respond to notification-related events
final BehaviorSubject<_ReceivedNotification>
    _didReceiveLocalNotificationSubject =
    BehaviorSubject<_ReceivedNotification>();

final BehaviorSubject<String> _selectNotificationSubject =
BehaviorSubject<String>();

/// data model for received messages
class _ReceivedNotification {
  _ReceivedNotification({
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
  LocalNotificationService._internal();

  factory LocalNotificationService() => _singleton;

  static final LocalNotificationService _singleton =
  LocalNotificationService._internal();

  /// Firebase messaging
  final _fcm = ProviderContainer().read(firebaseMessaging);

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
          _didReceiveLocalNotificationSubject.add(_ReceivedNotification(
              id: id, title: title, body: body, payload: payload));
        });

    final initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await _plugin.initialize(initializationSettings,
        onSelectNotification: (String payload) async =>
            _selectNotificationSubject.add(payload));

    /// observe token refresh
    _fcm.onTokenRefresh.listen((data) async => await _saveDeviceToken(data));

    if (Platform.isIOS) {
      await _fcm.requestPermission();
    } else {
      await _saveDeviceToken();
    }

    await Future.delayed(kNoDuration);

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

    await _requestPermissions();
    _configureDidReceiveLocalNotificationSubject();
    _configureSelectNotificationSubject();

    /// fixme -> register notification channels
    // await _pushNotification(
    //   {
    //     'title': kAppName,
    //     'body': kLoremText,
    //   },
    //   channelId: conversationChannelId,
    //   channelName: conversationChannelName,
    //   channelDesc: conversationChannelDesc,
    // );
    // await _pushNotification(
    //   {
    //     'title': kAppName,
    //     'body': kLoremText,
    //   },
    //   channelId: bookingChannelId,
    //   channelName: bookingChannelName,
    //   channelDesc: bookingChannelDesc,
    // );
    // await _pushNotification(
    //   {
    //     'title': kAppName,
    //     'body': kLoremText,
    //   },
    //   channelId: tokenChannelId,
    //   channelName: tokenChannelName,
    //   channelDesc: tokenChannelDesc,
    // );
  }

  Future<void> cancel({bool allNotifications = false, int id}) async {
    if (allNotifications) {
      await _plugin.cancelAll();
    } else if (id != null) await _plugin.cancel(id);
  }

  Future<void> _requestPermissions() async {
    /// request permission
    await ProviderContainer().read(firebaseMessaging).requestPermission();
    await _plugin
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
        .listen((_ReceivedNotification receivedNotification) async {
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

  /// save device token for current user
  Future<void> _saveDeviceToken([String token]) async {
    token = token ?? await _fcm.getToken();
    var container = ProviderContainer();
    final prefs = await container.read(sharedPreferencesProvider.future);
    var prefsRepo = container.read(prefsRepositoryProvider(prefs));

    if (prefsRepo.isLoggedIn) {
      var datasource = container.read(remoteDatasourceProvider(prefsRepo));

      /// get current user
      var artisan = await datasource.getArtisanById(id: prefsRepo.userId);
      await datasource.updateUser(artisan.copyWith(token: token));
    }
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
