import 'package:handyman/domain/models/models.dart';
import 'package:handyman/domain/repositories/repositories.dart';
import 'package:handyman/domain/sources/src/local.dart';
import 'package:handyman/domain/sources/src/remote.dart';
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

  @override
  Future<BaseArtisanService> getArtisanServiceById(
      {@required String id}) async {
    // fetch service from remote repo
    var service = await remote.getArtisanServiceById(id: id);

    // update local
    await local.updateArtisanService(id: id, artisanService: service);

    // provide local service instance
    return local.getArtisanServiceById(id: id);
  }

  @override
  Future<List<BaseArtisanService>> getArtisanServicesByCategory(
          {@required String categoryId}) async =>
      await local.getArtisanServicesByCategory(categoryId: categoryId);
}
