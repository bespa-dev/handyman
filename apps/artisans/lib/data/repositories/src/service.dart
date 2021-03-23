import 'package:handyman/domain/models/models.dart';
import 'package:handyman/domain/repositories/repositories.dart';
import 'package:handyman/domain/sources/src/local.dart';
import 'package:handyman/domain/sources/src/remote.dart';
import 'package:handyman/shared/shared.dart';
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
        if (service != null) {
          await local.updateArtisanService(id: id, artisanService: service);
        }
      }
    }
    return await local.getArtisanServices(id: id);
  }

  @override
  Future<void> updateArtisanService(
      {@required BaseArtisanService artisanService,
      @required String id}) async {
    await local.updateArtisanService(artisanService: artisanService, id: id);
    await remote.updateArtisanService(id: id, artisanService: artisanService);
  }

  @override
  Future<BaseArtisanService> getArtisanServiceById(
      {@required String id}) async {
    try {
      // fetch service from remote repo
      var service = await remote.getArtisanServiceById(id: id);

      // update local
      if (service != null) {
        await local.updateArtisanService(id: id, artisanService: service);
      }
    } catch (e) {
      logger.e(e);
    } finally {
      // provide local service instance
      return local.getArtisanServiceById(id: id);
    }
  }

  @override
  Future<List<BaseArtisanService>> getArtisanServicesByCategory(
          {@required String categoryId}) async =>
      await local.getArtisanServicesByCategory(categoryId: categoryId);
}
