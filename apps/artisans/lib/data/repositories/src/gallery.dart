/*
 * Copyright (c) 2021.
 * This application is owned by HandyMan LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */

import 'package:handyman/domain/models/src/gallery.dart';
import 'package:handyman/domain/repositories/repositories.dart';
import 'package:handyman/domain/sources/sources.dart';
import 'package:meta/meta.dart';

class GalleryRepositoryImpl extends BaseGalleryRepository {
  const GalleryRepositoryImpl({
    @required BaseLocalDatasource local,
    @required BaseRemoteDatasource remote,
  }) : super(local, remote);

  @override
  Stream<List<BaseGallery>> getPhotosForArtisan({String userId}) async* {
    yield* local.getPhotosForArtisan(userId: userId);
    remote.getPhotosForArtisan(userId: userId).listen((event) async {
      for (var value in event) {
        if (value != null) await local.updateGallery(gallery: value);
      }
    });
  }
}
