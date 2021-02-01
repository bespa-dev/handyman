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

import 'usecase/result.dart';
import 'usecase/usecase.dart';

class GetCurrentLocationUseCase extends NoParamsUseCase<BaseLocationMetadata> {
  const GetCurrentLocationUseCase(this._repo);

  final BaseLocationRepository _repo;

  @override
  Future<UseCaseResult<BaseLocationMetadata>> execute(_) async {
    try {
      var metadata = await _repo.getCurrentLocation();
      return UseCaseResult<BaseLocationMetadata>.success(metadata);
    } on Exception {
      return UseCaseResult<BaseLocationMetadata>.error(null);
    }
  }
}

class ObserveCurrentLocationUseCase
    extends ObservableUseCase<BaseLocationMetadata, void> {
  const ObserveCurrentLocationUseCase(this._repo);

  final BaseLocationRepository _repo;

  @override
  Future<UseCaseResult<Stream<BaseLocationMetadata>>> execute(_) async {
    try {
      var stream = _repo.observeCurrentLocation();
      return UseCaseResult<Stream<BaseLocationMetadata>>.success(
          stream.asBroadcastStream());
    } on Exception {
      return UseCaseResult<Stream<BaseLocationMetadata>>.error(null);
    }
  }
}

class GetLocationNameUseCase extends UseCase<String, BaseLocationMetadata> {
  const GetLocationNameUseCase(this._repo);

  final BaseLocationRepository _repo;

  @override
  Future<UseCaseResult<String>> execute(metadata) async {
    try {
      var locationName = await _repo.getLocationName(metadata: metadata);
      return UseCaseResult<String>.success(locationName);
    } on Exception {
      return UseCaseResult<String>.error(null);
    }
  }
}

class GetLocationCoordinatesUseCase
    extends UseCase<BaseLocationMetadata, String> {
  const GetLocationCoordinatesUseCase(this._repo);

  final BaseLocationRepository _repo;

  @override
  Future<UseCaseResult<BaseLocationMetadata>> execute(address) async {
    try {
      var location = await _repo.getLocationPosition(name: address);
      return UseCaseResult<BaseLocationMetadata>.success(location);
    } on Exception {
      return UseCaseResult<BaseLocationMetadata>.error(null);
    }
  }
}
