import 'package:lite/app/bloc/bloc.dart';
import 'package:lite/domain/models/models.dart';
import 'package:lite/domain/repositories/repositories.dart';
import 'package:lite/domain/usecases/usecases.dart';
import 'package:meta/meta.dart';

import 'search_event.dart';

class SearchBloc extends BaseBloc<SearchEvent> {
  SearchBloc({@required BaseSearchRepository repo})
      : assert(repo != null),
        _repo = repo;

  final BaseSearchRepository _repo;

  @override
  Stream<BlocState> mapEventToState(SearchEvent event) async* {
    if (event is SearchAllUsers) {
      yield BlocState.loadingState();

      var result = await SearchUseCase(_repo).execute(event.query);

      if (result is UseCaseResultSuccess<List<BaseUser>>) {
        yield BlocState<List<BaseUser>>.successState(data: result.value);
      } else {
        BlocState<List<BaseUser>>.errorState(failure: []);
      }
    }
  }
}

// SearchUseCase
