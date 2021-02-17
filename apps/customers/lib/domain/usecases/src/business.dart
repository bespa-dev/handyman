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
  const UploadBusinessPhotosUseCase(this._repo);

  final BaseBusinessRepository _repo;

  @override
  Future<UseCaseResult<void>> execute(
      UploadBusinessPhotosUseCaseParams params) async {
    try {
      await _repo.uploadBusinessPhotos(
          userId: params.userId, images: params.images);
      return UseCaseResult.success();
    } on Exception {
      return UseCaseResult.error('Failed to upload business images');
    }
  }
}

class GetBusinessesForArtisanUseCase
    extends UseCase<List<BaseBusiness>, String> {
  GetBusinessesForArtisanUseCase(this._repo);

  final BaseBusinessRepository _repo;

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

class GetBusinessUseCase extends UseCase<BaseBusiness, String> {
  GetBusinessUseCase(this._repo);

  final BaseBusinessRepository _repo;

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
  ObserveBusinessUseCase(this._repo);

  final BaseBusinessRepository _repo;

  @override
  Future<UseCaseResult<Stream<BaseBusiness>>> execute(String id) async {
    try {
      var results = _repo.observeBusinessById(id: id);
      return UseCaseResult<Stream<BaseBusiness>>.success(
          results.asBroadcastStream());
    } on Exception {
      return UseCaseResult.error();
    }
  }
}

class UploadBusinessUseCase
    extends UseCase<String, UploadBusinessUseCaseParams> {
  UploadBusinessUseCase(this._repo);

  final BaseBusinessRepository _repo;

  @override
  Future<UseCaseResult<String>> execute(
      UploadBusinessUseCaseParams params) async {
    try {
      final id = await _repo.uploadBusiness(
        docUrl: params.docUrl,
        name: params.name,
        artisan: params.artisan,
        location: params.location,
        nationalId: params.idUrl,
        birthCert: params.birthCertUrl,
      );
      return UseCaseResult<String>.success(id);
    } on Exception {
      return UseCaseResult.error();
    }
  }
}

class UpdateBusinessUseCase extends CompletableUseCase<BaseBusiness> {
  UpdateBusinessUseCase(this._repo);

  final BaseBusinessRepository _repo;

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
  const UploadBusinessPhotosUseCaseParams({this.images, this.userId});

  final List<String> images;
  final String userId;
}

class UploadBusinessUseCaseParams {
  const UploadBusinessUseCaseParams({
    @required this.docUrl,
    @required this.artisan,
    @required this.name,
    @required this.location,
    this.birthCertUrl,
    this.idUrl,
  });

  final String docUrl;
  final String idUrl;
  final String birthCertUrl;
  final String artisan;
  final String name;
  final String location;
}
