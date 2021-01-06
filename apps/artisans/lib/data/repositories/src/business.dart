/*
 * Copyright (c) 2021.
 * This application is owned by HandyMan LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */

import 'package:handyman/data/entities/entities.dart';
import 'package:handyman/domain/models/models.dart';
import 'package:handyman/domain/repositories/repositories.dart';
import 'package:handyman/domain/sources/sources.dart';
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

  @override
  Future<List<BaseBusiness>> getBusinessesForArtisan(
      {@required String artisan}) async {
    final businesses =
        await _remoteDatasource.getBusinessesForArtisan(artisan: artisan);
    for (var value in businesses) {
      if (value != null) await _localDatasource.updateBusiness(business: value);
    }
    return _localDatasource.getBusinessesForArtisan(artisan: artisan);
  }

  @override
  Future<String> uploadBusiness({
    @required String docUrl,
    @required String name,
    @required String artisan,
    @required double lat,
    @required double lng,
  }) async {
    final business = Business(
      id: Uuid().v4(),
      createdAt: DateTime.now().toIso8601String(),
      docUrl: docUrl,
      artisanId: artisan,
      name: name,
      location: LocationMetadata(
        lat: lat,
        lng: lng,
      ),
    );
    await _localDatasource.updateBusiness(business: business);
    await _remoteDatasource.updateBusiness(business: business);
    return business.id;
  }
}
