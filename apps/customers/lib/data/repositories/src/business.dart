/*
 * Copyright (c) 2021.
 * This application is owned by HandyMan LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */

import 'package:lite/data/entities/entities.dart';
import 'package:lite/domain/models/models.dart';
import 'package:lite/domain/repositories/repositories.dart';
import 'package:lite/domain/sources/sources.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

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
    final items = <BaseGallery>[];
    for (var item in images) {
      var gallery = Gallery(
        id: Uuid().v4(),
        createdAt: DateTime.now().toIso8601String(),
        userId: userId,
        imageUrl: item,
      );
      items.add(gallery);
    }

    await _localDatasource.uploadBusinessPhotos(galleryItems: items);
    await _remoteDatasource.uploadBusinessPhotos(galleryItems: items);
  }
}
