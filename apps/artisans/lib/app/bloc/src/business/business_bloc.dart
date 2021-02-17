import 'dart:async';

import 'package:handyman/app/bloc/bloc.dart';
import 'package:handyman/domain/models/models.dart';
import 'package:handyman/domain/repositories/repositories.dart';
import 'package:handyman/domain/usecases/usecases.dart';
import 'package:meta/meta.dart';

import 'business_event.dart';

class BusinessBloc extends BaseBloc<BusinessEvent> {
  BusinessBloc({@required BaseBusinessRepository repo})
      : assert(repo != null),
        _repo = repo;

  final BaseBusinessRepository _repo;

  @override
  Stream<BlocState> mapEventToState(
    BusinessEvent event,
  ) async* {
    yield* event.when(
      getBusinessesForArtisan: (e) => _mapEventToState(e),
      uploadBusiness: (e) => _mapEventToState(e),
      updateBusiness: (e) => _mapEventToState(e),
      getBusinessById: (e) => _mapEventToState(e),
      observeBusinessById: (e) => _mapEventToState(e),
    );
  }

  Stream<BlocState> _mapEventToState(BusinessEvent event) async* {
    yield BlocState.loadingState();

    if (event is GetBusinessesForArtisan) {
      final result =
          await GetBusinessesForArtisanUseCase(_repo).execute(event.artisanId);
      if (result is UseCaseResultSuccess<List<BaseBusiness>>) {
        yield BlocState<List<BaseBusiness>>.successState(data: result.value);
      } else {
        yield BlocState.errorState(
            failure: 'No businesses registered under this artisan');
      }
    } else if (event is UploadBusiness) {
      final result = await UploadBusinessUseCase(_repo).execute(
        UploadBusinessUseCaseParams(
          docUrl: event.docUrl,
          artisan: event.artisan,
          name: event.name,
          location: event.location,
          birthCertUrl: event.birthCert,
          idUrl: event.nationalId,
        ),
      );
      if (result is UseCaseResultSuccess<String>) {
        yield BlocState<String>.successState(data: result.value);
      } else {
        yield BlocState.errorState(
            failure: 'Failed to upload business details');
      }
    } else if (event is UpdateBusiness) {
      final result = await UpdateBusinessUseCase(_repo).execute(event.business);
      if (result is UseCaseResultSuccess) {
        yield BlocState.successState();
      } else {
        BlocState.errorState(failure: 'Failed to update business model');
      }
    } else if (event is GetBusinessById) {
      var result = await GetBusinessUseCase(_repo).execute(event.id);
      if (result is UseCaseResultSuccess<BaseBusiness>) {
        yield BlocState<BaseBusiness>.successState(data: result.value);
      } else {
        yield BlocState.errorState(
            failure: 'Cannot get business info at this time');
      }
    } else if (event is ObserveBusinessById) {
      var result = await ObserveBusinessUseCase(_repo).execute(event.id);
      if (result is UseCaseResultSuccess<Stream<BaseBusiness>>) {
        yield BlocState<Stream<BaseBusiness>>.successState(data: result.value);
      } else {
        yield BlocState.errorState(
            failure: 'Cannot observe business info at this time');
      }
    }
  }
}
