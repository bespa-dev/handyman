import 'package:lite/domain/models/models.dart';
import 'package:lite/domain/repositories/repositories.dart';
import 'package:lite/domain/sources/src/local.dart';
import 'package:lite/domain/sources/src/remote.dart';
import 'package:meta/meta.dart';

class ArtisanServiceRepositoryImpl extends BaseArtisanServiceRepository {
  const ArtisanServiceRepositoryImpl({
    @required BaseLocalDatasource local,
    @required BaseRemoteDatasource remote,
  }) : super(local, remote);

  @override
  Future<List<BaseArtisanService>> getArtisanServices() async =>
      await local.getArtisanServices();

  @override
  Future<void> updateArtisanService(
          {@required BaseArtisanService artisanService}) async =>
      await local.updateArtisanService(artisanService: artisanService);
}
