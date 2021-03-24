import 'package:handyman/app/bloc/bloc.dart';
import 'package:handyman/domain/models/models.dart';
import 'package:handyman/domain/repositories/repositories.dart';
import 'package:handyman/domain/usecases/usecases.dart';
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
      updateArtisanService: (e) => _mapEventToState(e),
      getServiceById: (e) => _mapEventToState(e),
      getAllArtisanServices: () => _mapEventToState(event),
      getArtisanServicesByCategory: (e) => _mapEventToState(e),
      resetAllPrices: () => _mapEventToState(event),
    );
  }

  Stream<BlocState> _mapEventToState(ArtisanServiceEvent event) async* {
    yield BlocState.loadingState();

    if (event is GetArtisanServices) {
      var result = await GetArtisanServicesUseCase(_repo).execute(event.id);
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
    } else if (event is GetArtisanServicesByCategory) {
      var result = await GetArtisanServicesByCategoryUseCase(_repo)
          .execute(event.categoryId);
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
      var result = await UpdateArtisanServiceUseCase(_repo).execute(
          UpdateArtisanServiceUseCaseParams(
              id: event.id, service: event.service));
      if (result is UseCaseResultSuccess) {
        yield BlocState.successState();
      } else {
        yield BlocState.errorState(failure: 'Failed to update service');
      }
    } else if (event is ResetAllPrices) {
      var result = await ResetAllServicePricesUseCase(_repo).execute(null);
      if (result is UseCaseResultSuccess) {
        yield BlocState.successState();
      } else {
        yield BlocState.errorState(failure: 'Failed to reset prices');
      }
    }
  }
}
