import 'dart:async';

import 'package:handyman/app/bloc/bloc.dart';
import 'package:handyman/domain/repositories/repositories.dart';
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
      getBusinessById: (e) => _mapEventToState(e),
      uploadBusiness: (e) => _mapEventToState(e),
    );
  }

  Stream<BlocState> _mapEventToState(BusinessEvent event) async* {
    yield BlocState.loadingState();

    if (event is GetBusinessesForArtisan) {
    } else if (event is GetBusinessById) {
    } else if (event is UploadBusiness) {}
  }
}
