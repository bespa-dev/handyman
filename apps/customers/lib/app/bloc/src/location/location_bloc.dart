import 'package:lite/app/bloc/bloc.dart';
import 'package:lite/domain/models/models.dart';
import 'package:lite/domain/repositories/repositories.dart';
import 'package:lite/domain/usecases/usecases.dart';
import 'package:meta/meta.dart';

import 'location_event.dart';

class LocationBloc extends BaseBloc<LocationEvent> {
  final BaseLocationRepository _repo;

  LocationBloc({@required BaseLocationRepository repo})
      : assert(repo != null),
        _repo = repo;

  @override
  Stream<BlocState> mapEventToState(LocationEvent event) async* {
    yield* event.when(
      getCurrentLocation: () => _mapEventToState(event),
      observeCurrentLocation: () => _mapEventToState(event),
      getLocationName: (e) => _mapEventToState(e),
      getLocationCoordinates: (e) => _mapEventToState(e),
    );
  }

  Stream<BlocState> _mapEventToState(LocationEvent event) async* {
    yield BlocState.loadingState();

    if (event is GetCurrentLocation) {
      var result = await GetCurrentLocationUseCase(_repo).execute(null);
      if (result is UseCaseResultSuccess<BaseLocationMetadata>) {
        yield BlocState<BaseLocationMetadata>.successState(data: result.value);
      } else {
        yield BlocState.errorState(failure: 'Cannot get current location');
      }
    } else if (event is ObserveCurrentLocation) {
      var result = await ObserveCurrentLocationUseCase(_repo).execute(null);
      if (result is UseCaseResultSuccess<Stream<BaseLocationMetadata>>) {
        yield BlocState<Stream<BaseLocationMetadata>>.successState(
            data: result.value);
      } else {
        yield BlocState.errorState(failure: 'Cannot observe current location');
      }
    } else if (event is GetLocationName) {
      var result = await GetLocationNameUseCase(_repo).execute(event.location);
      if (result is UseCaseResultSuccess<String>) {
        yield BlocState<String>.successState(data: result.value);
      } else {
        yield BlocState.errorState(failure: 'Cannot get location name');
      }
    } else if (event is GetLocationCoordinates) {
      var result =
          await GetLocationCoordinatesUseCase(_repo).execute(event.address);
      if (result is UseCaseResultSuccess<BaseLocationMetadata>) {
        yield BlocState<BaseLocationMetadata>.successState(data: result.value);
      } else {
        yield BlocState.errorState(failure: 'Cannot get location name');
      }
    }
  }
}
