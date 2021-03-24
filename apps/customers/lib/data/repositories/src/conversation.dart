/*
 * Copyright (c) 2021.
 * This application is owned by HandyMan LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */

import 'package:flutter/foundation.dart';
import 'package:lite/data/entities/entities.dart';
import 'package:lite/domain/models/models.dart';
import 'package:lite/domain/repositories/repositories.dart';
import 'package:lite/domain/sources/sources.dart';
import 'package:lite/shared/shared.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

class ConversationRepositoryImpl extends BaseConversationRepository {
  const ConversationRepositoryImpl({
    @required BaseLocalDatasource local,
    @required BaseRemoteDatasource remote,
  }) : super(local, remote);

  @override
  Stream<List<BaseConversation>> observeConversation(
      {String sender, String recipient}) async* {
    remote
        .observeConversation(sender: sender, recipient: recipient)
        .listen((event) async {
      for (var value in event) {
        if (value != null) {
          logger.d('Adding new message -> ${value.id}');
          await local.sendMessage(conversation: value);
        }
      }
    });
    yield* local.observeConversation(sender: sender, recipient: recipient);
  }

  @override
  Future<void> sendMessage(
      {String sender,
      String recipient,
      String body,
      ConversationFormat type}) async {
    final conversation = Conversation(
      id: Uuid().v4(),
      createdAt: DateTime.now().toIso8601String(),
      recipient: recipient,
      author: sender,
      body: body,
      format: type.name(),
    );

    await local.sendMessage(conversation: conversation);
    await remote.sendMessage(conversation: conversation);
  }
}
