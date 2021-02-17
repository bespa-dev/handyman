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

class BusinessRepositoryImpl extends BaseBusinessRepository {
  const BusinessRepositoryImpl({
    @required BaseLocalDatasource local,
    @required BaseRemoteDatasource remote,
  }) : super(local, remote);

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

    await local.uploadBusinessPhotos(galleryItems: items);
    await remote.uploadBusinessPhotos(galleryItems: items);
  }

  @override
  Future<List<BaseBusiness>> getBusinessesForArtisan(
      {@required String artisan}) async {
    final businesses = await remote.getBusinessesForArtisan(artisan: artisan);
    for (var value in businesses) {
      if (value != null) await local.updateBusiness(business: value);
    }
    return local.getBusinessesForArtisan(artisan: artisan);
  }

  @override
  Future<String> uploadBusiness({
    @required String docUrl,
    @required String name,
    @required String artisan,
    @required String location,
    String nationalId,
    String birthCert,
  }) async {
    final business = Business(
      id: Uuid().v4(),
      createdAt: DateTime.now().toIso8601String(),
      docUrl: docUrl,
      artisanId: artisan,
      name: name,
      location: location,
    );
    await local.updateBusiness(business: business);
    await remote.updateBusiness(business: business);
    if (nationalId != null && birthCert != null && docUrl != null) {
      var user = await local.getArtisanById(id: artisan);
      user = user.copyWith(nationalId: nationalId, birthCert: birthCert);
      await local.updateUser(user);
      await remote.updateUser(user);
    }
    return business.id;
  }

  @override
  Future<void> updateBusiness({@required BaseBusiness business}) async {
    await local.updateBusiness(business: business);
    await remote.updateBusiness(business: business);
  }

  @override
  Future<BaseBusiness> getBusinessById({@required String id}) async {
    var business = await remote.getBusinessById(id: id);
    if (business != null) await local.updateBusiness(business: business);
    return local.getBusinessById(id: id);
  }

  @override
  Stream<BaseBusiness> observeBusinessById({@required String id}) async* {
    yield* local.observeBusinessById(id: id);
    remote.observeBusinessById(id: id).listen((business) async* {
      if (business != null) {
        await local.updateBusiness(business: business);
        yield* local.observeBusinessById(id: id);
      }
    });
  }
}
