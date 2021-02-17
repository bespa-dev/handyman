/*
 * Copyright (c) 2021.
 * This application is owned by HandyMan LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */

import 'package:handyman/domain/models/src/user/artisan.dart';
import 'package:handyman/domain/models/src/user/user.dart';
import 'package:handyman/domain/repositories/repositories.dart';
import 'package:handyman/domain/sources/sources.dart';
import 'package:handyman/shared/shared.dart';
import 'package:meta/meta.dart';

class UserRepositoryImpl extends BaseUserRepository {

  const UserRepositoryImpl({
    @required BaseLocalDatasource local,
    @required BaseRemoteDatasource remote,
  }) : super(local, remote);

  @override
  Stream<BaseArtisan> currentUser() async* {
    yield* local.currentUser();
    remote.currentUser().listen((event) async {
      logger.d('Updating user -> $event');
      if (event != null) await local.updateUser(event);
    });
  }

  @override
  Future<BaseArtisan> getArtisanById({@required String id}) async {
    var artisan = await local.getArtisanById(id: id);
    return artisan ??= await remote.getArtisanById(id: id);
  }

  @override
  Future<BaseUser> getCustomerById({@required String id}) async {
    var customer = await local.getCustomerById(id: id);
    return customer ??= await remote.getCustomerById(id: id);
  }

  @override
  Stream<BaseArtisan> observeArtisanById({@required String id}) async* {
    yield* local.observeArtisanById(id: id);
    remote.observeArtisanById(id: id).listen((event) async {
      if (event != null) await local.updateUser(event);
    });
  }

  @override
  Stream<List<BaseArtisan>> observeArtisans(
      {@required String category}) async* {
    yield* local.observeArtisans(category: category);
    remote.observeArtisans(category: category).listen((event) async {
      for (var value in event) {
        if (value != null) await local.updateUser(value);
      }
    });
  }

  @override
  Stream<BaseUser> observeCustomerById({@required String id}) async* {
    yield* local.observeCustomerById(id: id);
    remote.observeCustomerById(id: id).listen((event) async {
      if (event != null) await local.updateUser(event);
    });
  }

  @override
  Future<void> updateUser({@required BaseUser user}) async {
    await local.updateUser(user);
    await remote.updateUser(user);
  }
}
