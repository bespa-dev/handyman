/*
 * Copyright (c) 2021.
 * This application is owned by HandyMan LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */

import 'package:lite/domain/models/models.dart';
import 'package:meta/meta.dart';

/// base messaging repository class
abstract class BaseMessagingRepository implements Exposable {
  /// show a notification
  Future<void> showNotification({
    @required String title,
    @required String body,
    @required PayloadType payload,
  });

  /// get notification permissions for iOS devices
  Future<bool> getNotificationPermissions();
}
