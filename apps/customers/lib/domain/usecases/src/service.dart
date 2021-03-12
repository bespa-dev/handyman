import 'package:lite/domain/models/models.dart';
import 'package:lite/domain/repositories/repositories.dart';
import 'package:meta/meta.dart';

import 'usecase/result.dart';
import 'usecase/usecase.dart';

class GetAllArtisanServicesUseCase
    extends NoParamsUseCase<List<BaseArtisanService>> {
  const GetAllArtisanServicesUseCase(this._repo);

  final BaseArtisanServiceRepository _repo;

  @override
  Future<UseCaseResult<List<BaseArtisanService>>> execute(_) async {
    try {
      var results = (await _repo.getArtisanServices(id: null)).toList();
      return UseCaseResult<List<BaseArtisanService>>.success(results);
    } on Exception {
      return UseCaseResult.error();
    }
  }
}

class GetArtisanServicesUseCase extends UseCase<List<BaseArtisanService>,
    GetAllArtisanServicesUseCaseParams> {
  const GetArtisanServicesUseCase(this._repo);

  final BaseArtisanServiceRepository _repo;

  @override
  Future<UseCaseResult<List<BaseArtisanService>>> execute(
      GetAllArtisanServicesUseCaseParams params) async {
    try {
      var results = await _repo.getArtisanServices(id: params.id);
      return UseCaseResult<List<BaseArtisanService>>.success(results);
    } on Exception {
      return UseCaseResult.error();
    }
  }
}

class GetCategoryServicesUseCase extends UseCase<List<BaseArtisanService>,
    String> {
  const GetCategoryServicesUseCase(this._repo);

  final BaseArtisanServiceRepository _repo;

  @override
  Future<UseCaseResult<List<BaseArtisanService>>> execute(
      String id) async {
    try {
      var results = await _repo.getCategoryServices(categoryId: id);
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
  UpdateArtisanServiceUseCase(this._repo);

  final BaseArtisanServiceRepository _repo;

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

class GetAllArtisanServicesUseCaseParams {
  const GetAllArtisanServicesUseCaseParams({@required this.id});

  final String id;
}
