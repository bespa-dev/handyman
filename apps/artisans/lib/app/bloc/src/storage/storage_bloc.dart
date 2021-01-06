import 'dart:async';

import 'package:handyman/app/bloc/bloc.dart';
import 'package:handyman/domain/repositories/repositories.dart';
import 'package:meta/meta.dart';

import 'storage_event.dart';

class StorageBloc extends BaseBloc<StorageEvent> {
  final BaseStorageRepository _repo;

  StorageBloc({@required BaseStorageRepository repo})
      : assert(repo != null),
        _repo = repo;

  @override
  Stream<BlocState> mapEventToState(
    StorageEvent event,
  ) async* {
    yield* event.when(
      uploadFile: (e) => _mapEventToState(e),
    );
  }

  Stream<BlocState> _mapEventToState(StorageEvent event) async* {
    yield BlocState.loadingState();
  }
}
