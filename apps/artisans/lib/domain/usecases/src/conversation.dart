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
import 'package:meta/meta.dart';

import 'usecase/result.dart';
import 'usecase/usecase.dart';

class SendMessageUseCaseParams {
  const SendMessageUseCaseParams({
    @required this.sender,
    @required this.recipient,
    @required this.message,
    @required this.type,
  });

  final String sender;
  final String recipient;
  final String message;
  final ConversationFormat type;
}

/// params for getting messages in a conversation
class GetMessagesForChatUseCaseParams {
  const GetMessagesForChatUseCaseParams({
    @required this.sender,
    @required this.recipient,
  });

  final String sender;
  final String recipient;
}

class SendMessageUseCase extends CompletableUseCase<SendMessageUseCaseParams> {
  const SendMessageUseCase(this._repo);

  final BaseConversationRepository _repo;

  @override
  Future<UseCaseResult<void>> execute(SendMessageUseCaseParams params) async {
    try {
      await _repo.sendMessage(
        sender: params.sender,
        recipient: params.recipient,
        body: params.message,
        type: params.type,
      );
      return UseCaseResult.success();
    } on Exception {
      return UseCaseResult.error('Unable to send message');
    }
  }
}

class GetMessagesForChatUseCase extends ObservableUseCase<
    List<BaseConversation>, GetMessagesForChatUseCaseParams> {
  const GetMessagesForChatUseCase(this._repo);

  final BaseConversationRepository _repo;

  @override
  Future<UseCaseResult<Stream<List<BaseConversation>>>> execute(
      GetMessagesForChatUseCaseParams params) async {
    try {
      var conversation = _repo.observeConversation(
          sender: params.sender, recipient: params.recipient);
      return UseCaseResult<Stream<List<BaseConversation>>>.success(
          conversation.asBroadcastStream());
    } on Exception {
      return UseCaseResult.error('Unable to send message');
    }
  }
}
