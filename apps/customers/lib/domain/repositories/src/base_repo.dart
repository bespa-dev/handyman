import 'package:lite/domain/models/models.dart';
import 'package:lite/domain/sources/sources.dart';

@Exposed()
abstract class BaseRepository implements Exposable {
  const BaseRepository(this.local, this.remote);

  final BaseLocalDatasource local;
  final BaseRemoteDatasource remote;
}
