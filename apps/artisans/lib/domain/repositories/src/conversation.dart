/*
 * Copyright (c) 2021.
 * This application is owned by HandyMan LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */

import 'package:handyman/domain/models/models.dart';
import 'package:handyman/domain/repositories/repositories.dart';
import 'package:handyman/domain/sources/src/local.dart';
import 'package:handyman/domain/sources/src/remote.dart';
import 'package:meta/meta.dart';

abstract class BaseConversationRepository extends BaseRepository {
  const BaseConversationRepository(BaseLocalDatasource local, BaseRemoteDatasource remote) : super(local, remote);

  /// Get [BaseConversation] between [sender] & [recipient]
  Stream<List<BaseConversation>> observeConversation(
      {@required String sender, @required String recipient});

  /// Send [BaseConversation]
  Future<void> sendMessage({
    @required String sender,
    @required String recipient,
    @required String body,
    @required ConversationFormat type,
  });

// /// show a notification
// Future<void> showNotification({
//   @required String title,
//   @required String body,
//   @required PayloadType payload,
// });
//
// /// get notification permissions for iOS devices
// Future<bool> getNotificationPermissions();
}
