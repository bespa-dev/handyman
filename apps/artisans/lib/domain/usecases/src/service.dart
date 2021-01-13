import 'package:handyman/domain/models/models.dart';
import 'package:handyman/domain/repositories/repositories.dart';

import 'usecase/result.dart';
import 'usecase/usecase.dart';

class GetAllArtisanServicesUseCase
    extends NoParamsUseCase<List<BaseArtisanService>> {
  final BaseArtisanServiceRepository _repo;

  const GetAllArtisanServicesUseCase(this._repo);

  @override
  Future<UseCaseResult<List<BaseArtisanService>>> execute(_) async {
    try {
      var results = (await _repo.getArtisanServices()).toList();
      return UseCaseResult<List<BaseArtisanService>>.success(results);
    } on Exception {
      return UseCaseResult.error();
    }
  }
}

class GetArtisanServicesUseCase
    extends UseCase<List<BaseArtisanService>, String> {
  final BaseArtisanServiceRepository _repo;

  const GetArtisanServicesUseCase(this._repo);

  @override
  Future<UseCaseResult<List<BaseArtisanService>>> execute(
      String category) async {
    try {
      var results = (await _repo.getArtisanServices())
          .where((item) => item.category == category)
          .toList();
      return UseCaseResult<List<BaseArtisanService>>.success(results);
    } on Exception {
      return UseCaseResult.error();
    }
  }
}

class GetServiceByIdUseCase extends UseCase<BaseArtisanService, String> {
  final BaseArtisanServiceRepository _repo;

  const GetServiceByIdUseCase(this._repo);

  @override
  Future<UseCaseResult<BaseArtisanService>> execute(String id) async {
    try {
      var results = (await _repo.getArtisanServices())
          .firstWhere((element) => element.id == id);
      return UseCaseResult<BaseArtisanService>.success(results);
    } on Exception {
      return UseCaseResult.error();
    }
  }
}

class UpdateArtisanServiceUseCase
    extends CompletableUseCase<BaseArtisanService> {
  final BaseArtisanServiceRepository _repo;

  UpdateArtisanServiceUseCase(this._repo);

  @override
  Future<UseCaseResult<void>> execute(BaseArtisanService service) async {
    try {
      await _repo.updateArtisanService(artisanService: service);
      return UseCaseResult.success();
    } on Exception {
      return UseCaseResult.error();
    }
  }
}
