
import 'package:handyman/app/bloc/bloc.dart';
import 'package:handyman/domain/repositories/repositories.dart';
import 'package:meta/meta.dart';
import 'service_event.dart';

class ArtisanServiceBloc extends BaseBloc<ArtisanServiceEvent> {
  final BaseArtisanServiceRepository _repo;

  ArtisanServiceBloc({@required BaseArtisanServiceRepository repo}) : assert(repo != null), _repo = repo;

  @override
  Stream<BlocState> mapEventToState(ArtisanServiceEvent event) {
    // yield*
  }

}