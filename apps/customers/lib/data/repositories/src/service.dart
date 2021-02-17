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
  Future<List<BaseArtisanService>> getArtisanServices(
      {@required String id}) async {
    var services = await remote.getArtisanServices(id: id);
    if (services.isNotEmpty) {
      for (var service in services) {
        await local.updateArtisanService(id: id, artisanService: service);
      }
    }
    return await local.getArtisanServices(id: id);
  }

  @override
  Future<void> updateArtisanService(
          {@required BaseArtisanService artisanService,
          @required String id}) async {
    await remote.updateArtisanService(id: id, artisanService: artisanService);
    await local.updateArtisanService(artisanService: artisanService, id: id);
  }
}
