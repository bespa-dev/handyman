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
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

class ConversationRepositoryImpl implements BaseConversationRepository {
  final BaseLocalDatasource _localDatasource;
  final BaseRemoteDatasource _remoteDatasource;

  ConversationRepositoryImpl({
    @required BaseLocalDatasource local,
    @required BaseRemoteDatasource remote,
  })  : _localDatasource = local,
        _remoteDatasource = remote;

  @override
  Stream<List<BaseConversation>> observeConversation(
      {String sender, String recipient}) async* {
    yield* _localDatasource.observeConversation(
        sender: sender, recipient: recipient);
    _remoteDatasource
        .observeConversation(sender: sender, recipient: recipient)
        .listen((event) async {
      for (var value in event) {
        if (value != null)
          await _localDatasource.sendMessage(conversation: value);
      }
    });
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

    await _localDatasource.sendMessage(conversation: conversation);
    await _remoteDatasource.sendMessage(conversation: conversation);
  }
}
