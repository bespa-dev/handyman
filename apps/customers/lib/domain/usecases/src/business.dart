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
      return UseCaseResult<List<BaseBusiness>>.error();
    }
  }
}

class GetBusinessUseCase extends UseCase<BaseBusiness, String> {
  final BaseBusinessRepository _repo;

  GetBusinessUseCase(this._repo);

  @override
  Future<UseCaseResult<BaseBusiness>> execute(String id) async {
    try {
      var results = await _repo.getBusinessById(id: id);
      return UseCaseResult<BaseBusiness>.success(results);
    } on Exception {
      return UseCaseResult.error();
    }
  }
}

class ObserveBusinessUseCase extends ObservableUseCase<BaseBusiness, String> {
  final BaseBusinessRepository _repo;

  ObserveBusinessUseCase(this._repo);

  @override
  Future<UseCaseResult<Stream<BaseBusiness>>> execute(String id) async {
    try {
      var results = _repo.observeBusinessById(id: id);
      return UseCaseResult<Stream<BaseBusiness>>.success(results.asBroadcastStream());
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
        location: params.location,
      );
      return UseCaseResult<String>.success(id);
    } on Exception {
      return UseCaseResult.error();
    }
  }
}

class UpdateBusinessUseCase extends CompletableUseCase<BaseBusiness> {
  final BaseBusinessRepository _repo;

  UpdateBusinessUseCase(this._repo);

  @override
  Future<UseCaseResult<void>> execute(BaseBusiness business) async {
    try {
      await _repo.updateBusiness(business: business);
      return UseCaseResult.success();
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
  final String location;

  const UploadBusinessUseCaseParams({
    @required this.docUrl,
    @required this.artisan,
    @required this.name,
    @required this.location,
  });
}
