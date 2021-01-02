/*
 * Copyright (c) 2021.
 * This application is owned by HandyMan LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */

import 'package:lite/domain/models/src/gallery.dart';
import 'package:lite/domain/repositories/repositories.dart';
import 'package:lite/domain/sources/sources.dart';
import 'package:meta/meta.dart';

class GalleryRepositoryImpl implements BaseGalleryRepository {
  final BaseLocalDatasource _localDatasource;
  final BaseRemoteDatasource _remoteDatasource;

  GalleryRepositoryImpl({
    @required BaseLocalDatasource local,
    @required BaseRemoteDatasource remote,
  })  : _localDatasource = local,
        _remoteDatasource = remote;

  @override
  Stream<List<BaseGallery>> getPhotosForArtisan({String userId}) async* {
    yield* _localDatasource.getPhotosForArtisan(userId: userId);
    _remoteDatasource.getPhotosForArtisan(userId: userId).listen((event) async {
      for (var value in event) {
        if (value != null) await _localDatasource.updateGallery(gallery: value);
      }
    });
  }
}
