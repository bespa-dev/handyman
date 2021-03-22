import 'package:lite/domain/models/models.dart';
import 'package:lite/domain/repositories/repositories.dart';
import 'package:lite/domain/sources/src/local.dart';
import 'package:lite/domain/sources/src/remote.dart';
import 'package:meta/meta.dart';

abstract class BaseArtisanServiceRepository extends BaseRepository {
  const BaseArtisanServiceRepository(
      BaseLocalDatasource local, BaseRemoteDatasource remote)
      : super(local, remote);

  Future<List<BaseArtisanService>> getArtisanServices({@required String id});

  Future<BaseArtisanService> getArtisanServiceById({@required String id});

  Future<List<BaseArtisanService>> getArtisanServicesByCategory(
      {@required String categoryId});

  Future<void> updateArtisanService(
      {@required String id, @required BaseArtisanService artisanService});
}
