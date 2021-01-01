/*
 * Copyright (c) 2021.
 * This application is owned by HandyMan LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */

import 'package:lite/domain/models/models.dart';
import 'package:lite/domain/repositories/repositories.dart';

import 'usecase/result.dart';
import 'usecase/usecase.dart';

class GetPhotosForArtisanUseCase
    extends ObservableUseCase<List<BaseGallery>, String> {
  final BaseGalleryRepository _repo;

  GetPhotosForArtisanUseCase(this._repo);

  @override
  Future<UseCaseResult<Stream<List<BaseGallery>>>> execute(
      String userId) async {
    try {
      final stream = _repo.getPhotosForArtisan(userId: userId);
      return UseCaseResult<Stream<List<BaseGallery>>>.success(
          stream.asBroadcastStream());
    } on Exception {
      return UseCaseResult.error();
    }
  }
}
