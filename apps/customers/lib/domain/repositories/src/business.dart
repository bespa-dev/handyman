/*
 * Copyright (c) 2021.
 * This application is owned by HandyMan LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */

import 'dart:io';

import 'package:lite/domain/models/models.dart';
import 'package:meta/meta.dart';

abstract class BaseBusinessRepository implements Exposable {
  /// Upload business [images]
  Future<void> uploadBusinessPhotos({
    @required String userId,
    @required List<File> images,
  });
}