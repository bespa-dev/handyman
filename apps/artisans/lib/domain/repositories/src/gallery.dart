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

abstract class BaseGalleryRepository extends BaseRepository {
  const BaseGalleryRepository(BaseLocalDatasource local, BaseRemoteDatasource remote) : super(local, remote);

  /// Get [BaseGallery] images for [BaseArtisan] by [userId]
  Stream<List<BaseGallery>> getPhotosForArtisan({@required String userId});
}
