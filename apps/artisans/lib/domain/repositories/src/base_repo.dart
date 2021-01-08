import 'package:handyman/domain/models/models.dart';
import 'package:handyman/domain/sources/sources.dart';

@Exposed()
abstract class BaseRepository implements Exposable {
  final BaseLocalDatasource local;
  final BaseRemoteDatasource remote;

  const BaseRepository(this.local, this.remote);
}
