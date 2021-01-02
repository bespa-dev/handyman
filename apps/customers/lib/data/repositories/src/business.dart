/*
 * Copyright (c) 2021.
 * This application is owned by HandyMan LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */

import 'package:lite/domain/repositories/repositories.dart';
import 'package:lite/domain/sources/sources.dart';
import 'package:meta/meta.dart';

class BusinessRepositoryImpl implements BaseBusinessRepository {
  final BaseLocalDatasource _localDatasource;
  final BaseRemoteDatasource _remoteDatasource;

  BusinessRepositoryImpl({
    @required BaseLocalDatasource local,
    @required BaseRemoteDatasource remote,
  })  : _localDatasource = local,
        _remoteDatasource = remote;

  @override
  Future<void> uploadBusinessPhotos(
      {String userId, List<String> images}) async {
    await _localDatasource.uploadBusinessPhotos(userId: userId, images: images);
    await _remoteDatasource.uploadBusinessPhotos(
        userId: userId, images: images);
  }
}
