/*
 * Copyright (c) 2021.
 * This application is owned by HandyMan LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:handyman/shared/shared.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

/// extensions on [List]
extension ListX on List<dynamic> {
  /// add an [item] to an existing [List] if it does not already contain it
  void addIfDoesNotExist(dynamic item) {
    if (this == null) return;
    if (!contains(item)) add(item);
  }

  /// remove an [item] from an existing [List] if it already contains it
  void removeIfExists(dynamic item) {
    if (this == null) return;
    if (contains(item)) remove(item);
  }

  /// remove an [item] to an existing [List] if it does not already contain it
  void toggleAddOrRemove(dynamic item) {
    if (this == null) return;
    if (contains(item)) {
      remove(item);
    } else {
      add(item);
    }
  }
}

/// extensions on [DateTime]
extension DateTimeExtensionX on DateTime {
  TimeOfDay toTimeOfDay() {
    return TimeOfDay(hour: hour, minute: minute);
  }
}

/// extensions on [TimeOfDay]
extension TimeOfDayExtensionX on TimeOfDay {
  DateTime toDateTime() {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day, hour, minute);
  }
}

/// extensions on [Iterable]
/// https://stackoverflow.com/questions/53547997/sort-a-list-of-objects-in-flutter-dart-by-property-value
extension IterableX<T> on Iterable<T> {
  Iterable<T> sortBy<R extends Comparable<R>>(R Function(T) selector) =>
      toList()..sort((a, b) => selector(a).compareTo(selector(b)));

  Iterable<T> sortByDescending<R extends Comparable<R>>(
          R Function(T) selector) =>
      sortBy(selector).toList().reversed;
}

/// extension on any [Object]
extension ItemX on Object {
  /// convert any object to a stream
  Stream<T> asStream<T>() => Stream<T>.value(this as T);
}

extension StringX on String {
  /// download and save image file locally
  Future<String> _downloadAndSaveImage(String fileName) async {
    var directory = await getApplicationDocumentsDirectory();
    var filePath = '${directory.path}/$fileName';
    try {
      var response = await http.get(this);
      var file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);
    } catch (e) {
      logger.e(e);
    }
    return filePath;
  }
}
