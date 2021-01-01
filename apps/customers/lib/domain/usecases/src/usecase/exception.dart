/*
 * Copyright (c) 2021.
 * This application is owned by HandyMan LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */

import 'package:lite/domain/usecases/usecases.dart';
import 'package:lite/shared/shared.dart';

/// exception implementation for [UseCase]s
class UseCaseException implements Exception {
  final String message;

  const UseCaseException._(this.message);

  factory UseCaseException.create(String message) {
    logger.e(message); // log message to console
    return UseCaseException._(message);
  }
}
