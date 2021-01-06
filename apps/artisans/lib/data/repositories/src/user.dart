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
import 'package:meta/meta.dart';

class UserRepositoryImpl implements BaseUserRepository {
  final BaseLocalDatasource _localDatasource;
  final BaseRemoteDatasource _remoteDatasource;

  UserRepositoryImpl({
    @required BaseLocalDatasource local,
    @required BaseRemoteDatasource remote,
  })  : _localDatasource = local,
        _remoteDatasource = remote;

  @override
  Stream<BaseArtisan> currentUser() async* {
    yield* _localDatasource.currentUser();
    _remoteDatasource.currentUser().listen((event) async {
      if (event != null) await _localDatasource.updateUser(event);
    });
  }

  @override
  Future<BaseArtisan> getArtisanById({@required String id}) async {
    var artisan = await _localDatasource.getArtisanById(id: id);
    return artisan ??= await _remoteDatasource.getArtisanById(id: id);
  }

  @override
  Future<BaseUser> getCustomerById({@required String id}) async {
    var customer = await _localDatasource.getCustomerById(id: id);
    return customer ??= await _remoteDatasource.getCustomerById(id: id);
  }

  @override
  Stream<BaseArtisan> observeArtisanById({@required String id}) async* {
    yield* _localDatasource.observeArtisanById(id: id);
    _remoteDatasource.observeArtisanById(id: id).listen((event) async {
      if (event != null) await _localDatasource.updateUser(event);
    });
  }

  @override
  Stream<List<BaseArtisan>> observeArtisans(
      {@required String category}) async* {
    yield* _localDatasource.observeArtisans(category: category);
    _remoteDatasource.observeArtisans(category: category).listen((event) async {
      for (var value in event) {
        if (value != null) await _localDatasource.updateUser(value);
      }
    });
  }

  @override
  Stream<BaseUser> observeCustomerById({@required String id}) async* {
    yield* _localDatasource.observeCustomerById(id: id);
    _remoteDatasource.observeCustomerById(id: id).listen((event) async {
      if (event != null) await _localDatasource.updateUser(event);
    });
  }

  @override
  Future<void> updateUser({@required BaseUser user}) async {
    await _localDatasource.updateUser(user);
    await _remoteDatasource.updateUser(user);
  }
}
