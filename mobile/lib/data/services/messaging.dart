import 'dart:convert';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:handyman/app/model/prefs_provider.dart';
import 'package:handyman/app/routes/route.gr.dart';
import 'package:handyman/core/service_locator.dart';
import 'package:handyman/core/utils.dart';
import 'package:handyman/domain/services/auth.dart';
import 'package:handyman/domain/services/data.dart';
import 'package:handyman/domain/services/messaging.dart';

class MessagingServiceImpl implements MessagingService {
  static FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  MessagingServiceImpl._() {
    //_initPlugins();
  }

  // Creates an instance of the class and initializes plugins
  static MessagingServiceImpl get instance => MessagingServiceImpl._();

  void _initPlugins() async {
    // initialise the plugin. `logo_colored` needs to be a added as
    // a drawable resource to the Android head project
    var initializationSettingsAndroid =
        AndroidInitializationSettings('app_logo');
    var initializationSettingsIOS = IOSInitializationSettings(
        requestSoundPermission: true,
        requestBadgePermission: true,
        requestAlertPermission: true,
        onDidReceiveLocalNotification: _onDidReceiveLocalNotification);
    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    await FlutterLocalNotificationsPlugin().initialize(initializationSettings,
        onSelectNotification: _selectNotification);

    // Request notification permissions
    final msgService = sl.get<FirebaseMessaging>();
    if (Platform.isIOS) {
      msgService.requestNotificationPermissions(const IosNotificationSettings(
          sound: true, badge: true, alert: true, provisional: true));
      msgService.onIosSettingsRegistered
          .listen((IosNotificationSettings settings) {
        debugPrint("Settings registered: $settings");
      });
    }

    // Get device token
    final token = await msgService.getToken();
    debugPrint("MessagingServiceImpl._initPlugins: Token => $token");

    // Get logged in user instance, if any
    var authService = sl.get<AuthService>();
    var currentUser = await authService.currentUser().first;
    if (currentUser != null && token != null) {
      // Update user token
      var updatedUser = currentUser.user?.copyWith(token: token);
      debugPrint(
          "MessagingServiceImpl._initPlugins: Updated user => $updatedUser");
      if (updatedUser != null)
        await sl.get<DataService>().updateUser(currentUser);
    }

    // Configure messaging
    msgService.configure(
      onBackgroundMessage: Platform.isIOS ? null : _backgroundMessageHandler,
      onMessage: (Map<String, dynamic> message) async {
        final notification = message["notification"];
        debugPrint("onMessage: $message");

        final title = notification["title"];
        final body = notification["body"];

        showNotification(
          title: title,
          body: body,
          payload: notification["data"]?.toString(),
        );
      },
      onLaunch: (Map<String, dynamic> message) async {
        debugPrint("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        debugPrint("onResume: $message");
      },
    );
  }

  @override
  void showNotification(
      {String title,
      String body,
      String channel = NotificationUtils.BOOKING_CHANNEL,
      dynamic payload}) async {
    // get user login state
    final isLoggedIn = sl.get<PrefsProvider>().isLoggedIn;

    if (isLoggedIn) {
      var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        channel,
        channel,
        channel == NotificationUtils.BOOKING_CHANNEL
            ? 'Get booking request notifications'
            : 'Conversation notifications',
        importance: Importance.Max,
        priority: Priority.High,
        enableLights: true,
        enableVibration: true,
        ticker: 'ticker',
      );
      var iOSPlatformChannelSpecifics = IOSNotificationDetails();
      var platformChannelSpecifics = NotificationDetails(
          androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
      await _flutterLocalNotificationsPlugin.show(
        0,
        title,
        body,
        platformChannelSpecifics,
        payload: jsonEncode(
          NotificationPayload(
              payload?.toJson(),
              channel == NotificationUtils.BOOKING_CHANNEL
                  ? PayloadType.BOOKING
                  : PayloadType.CONVERSATION),
        ),
      );
    }
  }

  static Future _selectNotification(String payload) async {
    if (payload != null)
      debugPrint('_selectNotification => notification payload: ' + payload);

    // Send user to notifications page
    ExtendedNavigator.root.push(
      Routes.notificationPage,
      arguments: NotificationPageArguments(
        payload: NotificationPayload.fromJson(jsonDecode(payload)),
      ),
    );
  }

  static Future _onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    debugPrint("_onDidReceiveLocalNotification => $title");
  }

  // Handles background messages
  static Future _backgroundMessageHandler(Map<String, dynamic> message) async {
    debugPrint("onBackgroundMessage: $message");
  }

  @override
  Future<bool> getNotificationPermissions() async =>
      await _flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
}
