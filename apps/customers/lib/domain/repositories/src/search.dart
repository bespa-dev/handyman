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

abstract class BaseSearchRepository implements Exposable {
  /// Search for any [BaseArtisan]
  Future<List<BaseUser>> searchFor({@required String query, String categoryId});
}
