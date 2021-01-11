/*
 * Copyright (c) 2021.
 * This application is owned by lite LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */

import 'package:lite/domain/models/models.dart';
import 'package:lite/domain/repositories/repositories.dart';
import 'package:lite/domain/sources/src/local.dart';
import 'package:lite/domain/sources/src/remote.dart';
import 'package:meta/meta.dart';

/// base user repository class
abstract class BaseUserRepository extends BaseRepository {
  const BaseUserRepository(BaseLocalDatasource local, BaseRemoteDatasource remote) : super(local, remote);

  /// Update [BaseUser] profile information
  Future<void> updateUser({@required BaseUser user});

  /// observe current user
  Stream<BaseUser> currentUser();

  /// Get all [BaseArtisan]
  Stream<List<BaseArtisan>> observeArtisans({@required String category});

  /// Get an [BaseArtisan] by [id]
  Stream<BaseArtisan> observeArtisanById({@required String id});

  /// Get [BaseUser] by [id]
  Stream<BaseUser> observeCustomerById({@required String id});

  /// Get an [BaseArtisan] by [id]
  Future<BaseArtisan> getArtisanById({@required String id});

  /// Get [BaseUser] by [id]
  Future<BaseUser> getCustomerById({@required String id});
}
