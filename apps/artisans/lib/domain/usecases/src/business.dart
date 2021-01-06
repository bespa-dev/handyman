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
import 'package:meta/meta.dart';

import 'usecase/result.dart';
import 'usecase/usecase.dart';

class UploadBusinessPhotosUseCase
    extends CompletableUseCase<UploadBusinessPhotosUseCaseParams> {
  final BaseBusinessRepository _repo;

  const UploadBusinessPhotosUseCase(this._repo);

  @override
  Future<UseCaseResult<void>> execute(
      UploadBusinessPhotosUseCaseParams params) async {
    try {
      await _repo.uploadBusinessPhotos(
          userId: params.userId, images: params.images);
      return UseCaseResult.success();
    } on Exception {
      return UseCaseResult.error("Failed to upload business images");
    }
  }
}

class GetBusinessesForArtisanUseCase
    extends UseCase<List<BaseBusiness>, String> {
  final BaseBusinessRepository _repo;

  GetBusinessesForArtisanUseCase(this._repo);

  @override
  Future<UseCaseResult<List<BaseBusiness>>> execute(String artisan) async {
    try {
      var results = await _repo.getBusinessesForArtisan(artisan: artisan);
      return UseCaseResult<List<BaseBusiness>>.success(results);
    } on Exception {
      return UseCaseResult.error();
    }
  }
}

class UploadBusinessUseCase
    extends UseCase<String, UploadBusinessUseCaseParams> {
  final BaseBusinessRepository _repo;

  UploadBusinessUseCase(this._repo);

  @override
  Future<UseCaseResult<String>> execute(
      UploadBusinessUseCaseParams params) async {
    try {
      final id = await _repo.uploadBusiness(
        docUrl: params.docUrl,
        name: params.name,
        artisan: params.artisan,
        lat: params.lat,
        lng: params.lng,
      );
      return UseCaseResult<String>.success(id);
    } on Exception {
      return UseCaseResult.error();
    }
  }
}

/// params
class UploadBusinessPhotosUseCaseParams {
  final List<String> images;
  final String userId;

  const UploadBusinessPhotosUseCaseParams({this.images, this.userId});
}

class UploadBusinessUseCaseParams {
  final String docUrl;
  final String artisan;
  final String name;
  final double lat;
  final double lng;

  const UploadBusinessUseCaseParams({
    @required this.docUrl,
    @required this.artisan,
    @required this.name,
    @required this.lat,
    @required this.lng,
  });
}
