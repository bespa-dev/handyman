import 'dart:async';

import 'package:handyman/app/bloc/bloc.dart';
import 'package:handyman/domain/models/models.dart';
import 'package:handyman/domain/repositories/repositories.dart';
import 'package:handyman/domain/usecases/src/usecase/result.dart';
import 'package:handyman/domain/usecases/usecases.dart';
import 'package:meta/meta.dart';

import 'business_event.dart';

class BusinessBloc extends BaseBloc<BusinessEvent> {
  final BaseBusinessRepository _repo;

  BusinessBloc({@required BaseBusinessRepository repo})
      : assert(repo != null),
        _repo = repo;

  @override
  Stream<BlocState> mapEventToState(
    BusinessEvent event,
  ) async* {
    yield* event.when(
      getBusinessesForArtisan: (e) => _mapEventToState(e),
      uploadBusiness: (e) => _mapEventToState(e),
    );
  }

  Stream<BlocState> _mapEventToState(BusinessEvent event) async* {
    yield BlocState.loadingState();

    if (event is GetBusinessesForArtisan) {
      final result =
          await GetBusinessesForArtisanUseCase(_repo).execute(event.artisanId);
      if (result is UseCaseResultSuccess<List<BaseBusiness>>) {
        yield BlocState.successState(data: result.value);
      } else
        yield BlocState.errorState(
            failure: "No businesses registered under this artisan");
    } else if (event is UploadBusiness) {
      final result = await UploadBusinessUseCase(_repo).execute(
        UploadBusinessUseCaseParams(
          docUrl: event.docUrl,
          artisan: event.artisan,
          name: event.name,
          location: event.location,
        ),
      );
      if (result is UseCaseResultSuccess<String>) {
        yield BlocState<String>.successState(data: result.value);
      } else
        yield BlocState.errorState(
            failure: "Failed to upload business details");
    }
  }
}
