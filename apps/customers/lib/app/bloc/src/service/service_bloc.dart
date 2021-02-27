import 'package:lite/app/bloc/bloc.dart';
import 'package:lite/domain/models/models.dart';
import 'package:lite/domain/repositories/repositories.dart';
import 'package:lite/domain/usecases/usecases.dart';
import 'package:meta/meta.dart';

import 'service_event.dart';

class ArtisanServiceBloc extends BaseBloc<ArtisanServiceEvent> {
  ArtisanServiceBloc({@required BaseArtisanServiceRepository repo})
      : assert(repo != null),
        _repo = repo;

  final BaseArtisanServiceRepository _repo;

  @override
  Stream<BlocState> mapEventToState(ArtisanServiceEvent event) async* {
    yield* event.when(
      getArtisanServices: (e) => _mapEventToState(e),
      getCategoryServices: (e) => _mapEventToState(e),
      updateArtisanService: (e) => _mapEventToState(e),
      getServiceById: (e) => _mapEventToState(e),
      getAllArtisanServices: () => _mapEventToState(event),
    );
  }

  Stream<BlocState> _mapEventToState(ArtisanServiceEvent event) async* {
    yield BlocState.loadingState();

    if (event is GetArtisanServices) {
      var result = await GetArtisanServicesUseCase(_repo)
          .execute(GetAllArtisanServicesUseCaseParams(id: event.id));
      if (result is UseCaseResultSuccess<List<BaseArtisanService>>) {
        yield BlocState<List<BaseArtisanService>>.successState(
            data: result.value);
      } else {
        yield BlocState.errorState(failure: 'Failed to load services');
      }
    } else if (event is GetCategoryServices) {
      var result =
          await GetCategoryServicesUseCase(_repo).execute(event.categoryId);
      if (result is UseCaseResultSuccess<List<BaseArtisanService>>) {
        yield BlocState<List<BaseArtisanService>>.successState(
            data: result.value);
      } else {
        yield BlocState.errorState(failure: 'Failed to load services');
      }
    } else if (event is GetAllArtisanServices) {
      var result = await GetAllArtisanServicesUseCase(_repo).execute(null);
      if (result is UseCaseResultSuccess<List<BaseArtisanService>>) {
        yield BlocState<List<BaseArtisanService>>.successState(
            data: result.value);
      } else {
        yield BlocState.errorState(failure: 'Failed to load services');
      }
    } else if (event is GetServiceById) {
      var result = await GetServiceByIdUseCase(_repo).execute(event.id);
      if (result is UseCaseResultSuccess<BaseArtisanService>) {
        yield BlocState<BaseArtisanService>.successState(data: result.value);
      } else {
        yield BlocState.errorState(failure: 'Failed to load services');
      }
    } else if (event is UpdateArtisanService) {
      var result =
          await UpdateArtisanServiceUseCase(_repo).execute(event.service);
      if (result is UseCaseResultSuccess) {
        yield BlocState.successState();
      } else {
        yield BlocState.errorState(failure: 'Failed to update service');
      }
    }
  }
}
