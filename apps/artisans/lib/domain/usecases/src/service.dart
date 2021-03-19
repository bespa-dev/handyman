import 'package:handyman/domain/models/models.dart';
import 'package:handyman/domain/repositories/repositories.dart';
import 'package:meta/meta.dart';

import 'usecase/result.dart';
import 'usecase/usecase.dart';

class GetAllArtisanServicesUseCase
    extends UseCase<List<BaseArtisanService>, String> {
  const GetAllArtisanServicesUseCase(this._repo);

  final BaseArtisanServiceRepository _repo;

  @override
  Future<UseCaseResult<List<BaseArtisanService>>> execute(id) async {
    try {
      var results = await _repo.getArtisanServices(id: id);
      return UseCaseResult<List<BaseArtisanService>>.success(results);
    } on Exception {
      return UseCaseResult.error();
    }
  }
}

class GetArtisanServicesByCategoryUseCase
    extends UseCase<List<BaseArtisanService>, String> {
  const GetArtisanServicesByCategoryUseCase(this._repo);

  final BaseArtisanServiceRepository _repo;

  @override
  Future<UseCaseResult<List<BaseArtisanService>>> execute(categoryId) async {
    try {
      var results = await _repo.getArtisanServicesByCategory(categoryId: categoryId);
      return UseCaseResult<List<BaseArtisanService>>.success(results);
    } on Exception {
      return UseCaseResult.error();
    }
  }
}

class GetArtisanServicesUseCase
    extends UseCase<List<BaseArtisanService>, String> {
  const GetArtisanServicesUseCase(this._repo);

  final BaseArtisanServiceRepository _repo;

  @override
  Future<UseCaseResult<List<BaseArtisanService>>> execute(String id) async {
    try {
      var results = await _repo.getArtisanServices(id: id);
      return UseCaseResult<List<BaseArtisanService>>.success(results);
    } on Exception {
      return UseCaseResult.error();
    }
  }
}

class GetServiceByIdUseCase extends UseCase<BaseArtisanService, String> {
  const GetServiceByIdUseCase(this._repo);

  final BaseArtisanServiceRepository _repo;

  @override
  Future<UseCaseResult<BaseArtisanService>> execute(String id) async {
    try {
      var results = await _repo.getArtisanServiceById(id: id);
      return UseCaseResult<BaseArtisanService>.success(results);
    } on Exception {
      return UseCaseResult.error();
    }
  }
}

class UpdateArtisanServiceUseCase
    extends CompletableUseCase<UpdateArtisanServiceUseCaseParams> {
  UpdateArtisanServiceUseCase(this._repo);

  final BaseArtisanServiceRepository _repo;

  @override
  Future<UseCaseResult<void>> execute(
      UpdateArtisanServiceUseCaseParams params) async {
    try {
      await _repo.updateArtisanService(
          id: params.id, artisanService: params.service);
      return UseCaseResult.success();
    } on Exception {
      return UseCaseResult.error();
    }
  }
}

class UpdateArtisanServiceUseCaseParams {
  const UpdateArtisanServiceUseCaseParams({
    @required this.id,
    @required this.service,
  });

  final String id;
  final BaseArtisanService service;
}
