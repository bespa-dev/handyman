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

class GetCurrentLocationUseCase extends NoParamsUseCase<LocationMetadata> {
  final BaseLocationRepository _repo;

  const GetCurrentLocationUseCase(this._repo);

  @override
  Future<UseCaseResult<LocationMetadata>> execute(_) async {
    try {
      var metadata = await _repo.getCurrentLocation();
      return UseCaseResult<LocationMetadata>.success(metadata);
    } on Exception {
      return UseCaseResult.error("Failed to get current user location");
    }
  }
}

class ObserveCurrentLocationUseCase
    extends ObservableUseCase<LocationMetadata, void> {
  final BaseLocationRepository _repo;

  const ObserveCurrentLocationUseCase(this._repo);

  @override
  Future<UseCaseResult<Stream<LocationMetadata>>> execute(_) async {
    try {
      var stream = _repo.observeCurrentLocation();
      return UseCaseResult<Stream<LocationMetadata>>.success(
          stream.asBroadcastStream());
    } on Exception {
      return UseCaseResult.error("Failed to get current user location");
    }
  }
}

class GetLocationNameUseCase extends UseCase<String, LocationMetadata> {
  final BaseLocationRepository _repo;

  const GetLocationNameUseCase(this._repo);

  @override
  Future<UseCaseResult<String>> execute(metadata) async {
    try {
      var locationName = await _repo.getLocationName(metadata: metadata);
      return UseCaseResult.success(locationName);
    } on Exception {
      return UseCaseResult.error("Unable to get location name");
    }
  }
}
