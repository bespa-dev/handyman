/*
 * Copyright (c) 2021.
 * This application is owned by HandyMan LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */

import 'package:lite/domain/models/src/user/artisan.dart';
import 'package:lite/domain/models/src/user/user.dart';
import 'package:lite/domain/repositories/repositories.dart';
import 'package:lite/domain/sources/sources.dart';
import 'package:lite/shared/shared.dart';
import 'package:meta/meta.dart';

class UserRepositoryImpl extends BaseUserRepository {
  const UserRepositoryImpl({
    @required BaseLocalDatasource local,
    @required BaseRemoteDatasource remote,
  }) : super(local, remote);

  @override
  Stream<BaseUser> currentUser() async* {
    remote.currentUser().listen((event) async {
      if (event != null) await local.updateUser(event);
    });
    yield* local.currentUser();
  }

  @override
  Future<BaseArtisan> getArtisanById({@required String id}) async {
    var artisan = await local.getArtisanById(id: id);
    return artisan ??= await remote.getArtisanById(id: id);
  }

  @override
  Future<BaseUser> getCustomerById({@required String id}) async {
    var customer = await remote.getCustomerById(id: id);
    return customer ??= await local.getCustomerById(id: id);
  }

  @override
  Stream<BaseArtisan> observeArtisanById({@required String id}) async* {
    remote.observeArtisanById(id: id).listen((event) async {
      if (event != null) await local.updateUser(event);
    });
    yield* local.observeArtisanById(id: id);
  }

  @override
  Stream<List<BaseArtisan>> observeArtisans(
      {@required String category}) async* {
    remote.observeArtisans(category: category).listen((event) {
      for (var value in event) {
        if (value != null) local.updateUser(value);
      }
    });
    yield* local.observeArtisans(category: category);
  }

  @override
  Stream<BaseUser> observeCustomerById({@required String id}) async* {
    remote.observeCustomerById(id: id).listen((event) async {
      if (event != null) await local.updateUser(event);
    });
    yield* local.observeCustomerById(id: id);
  }

  @override
  Future<void> updateUser({@required BaseUser user}) async {
    await local.updateUser(user);
    await remote.updateUser(user);
  }
}
