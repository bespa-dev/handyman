/*
 * Copyright (c) 2021.
 * This application is owned by HandyMan LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */

import 'package:handyman/domain/models/models.dart';
import 'package:handyman/domain/repositories/repositories.dart';
import 'package:handyman/domain/sources/src/local.dart';
import 'package:handyman/domain/sources/src/remote.dart';
import 'package:meta/meta.dart';

abstract class BaseSearchRepository extends BaseRepository {
  const BaseSearchRepository(BaseLocalDatasource local, BaseRemoteDatasource remote) : super(local, remote);

  /// Search for any [BaseArtisan]
  Future<List<BaseUser>> searchFor({@required String query, String categoryId});
}
