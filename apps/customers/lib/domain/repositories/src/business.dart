/*
 * Copyright (c) 2021.
 * This application is owned by lite LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */

import 'package:lite/domain/models/models.dart';
import 'package:lite/domain/repositories/repositories.dart';
import 'package:lite/domain/sources/src/local.dart';
import 'package:lite/domain/sources/src/remote.dart';
import 'package:meta/meta.dart';

abstract class BaseBusinessRepository extends BaseRepository {
  const BaseBusinessRepository(BaseLocalDatasource local, BaseRemoteDatasource remote) : super(local, remote);

  /// Upload business [images]
  Future<void> uploadBusinessPhotos({
    @required String userId,
    @required List<String> images,
  });

  Future<List<BaseBusiness>> getBusinessesForArtisan(
      {@required String artisan});

  Future<String> uploadBusiness({
    @required String docUrl,
    @required String name,
    @required String artisan,
    @required String location,
  });

  Future<void> updateBusiness({@required BaseBusiness business});

  Future<BaseBusiness> getBusinessById({@required String id});

  Stream<BaseBusiness> observeBusinessById({@required String id});
}
