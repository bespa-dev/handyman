/*
 * Copyright (c) 2021.
 * This application is owned by HandyMan LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */

import 'package:flutter/material.dart';

/// extensions on [List]
extension ListX on List<dynamic> {
  /// add an [item] to an existing [List] if it does not already contain it
  void addIfDoesNotExist(dynamic item) {
    if (this == null) return;
    if (!this.contains(item)) this.add(item);
  }

  /// remove an [item] to an existing [List] if it does not already contain it
  void removeIfExists(dynamic item) {
    if (this == null) return;
    if (this.contains(item)) this.remove(item);
  }

  /// remove an [item] to an existing [List] if it does not already contain it
  void toggleAddOrRemove(dynamic item) {
    if (this == null) return;
    if (this.contains(item))
      this.remove(item);
    else
      this.add(item);
  }
}

/// extensions on [DateTime]
extension DateTimeExtensionX on DateTime {
  TimeOfDay toTimeOfDay() {
    return TimeOfDay(hour: this.hour, minute: this.minute);
  }
}

/// extensions on [TimeOfDay]
extension TimeOfDayExtensionX on TimeOfDay {
  DateTime toDateTime() {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day, this.hour, this.minute);
  }
}
