/*
 * Copyright (c) 2021.
 * This application is owned by HandyMan LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */

import 'package:lite/domain/models/models.dart';
import 'package:lite/domain/repositories/repositories.dart';
import 'package:meta/meta.dart';

import 'usecase/result.dart';
import 'usecase/usecase.dart';

class SendMessageUseCaseParams {
  final String sender;
  final String recipient;
  final String message;
  final ConversationFormat type;

  const SendMessageUseCaseParams({
    @required this.sender,
    @required this.recipient,
    @required this.message,
    @required this.type,
  });
}

/// params for getting messages in a conversation
class GetMessagesForChatUseCaseParams {
  final String sender;
  final String recipient;

  const GetMessagesForChatUseCaseParams({
    @required this.sender,
    @required this.recipient,
  });
}

class SendMessageUseCase extends CompletableUseCase<SendMessageUseCaseParams> {
  final BaseConversationRepository _repo;

  SendMessageUseCase(this._repo);

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
      return UseCaseResult.error("Unable to send message");
    }
  }
}

class GetMessagesForChatUseCase extends ObservableUseCase<
    List<BaseConversation>, GetMessagesForChatUseCaseParams> {
  final BaseConversationRepository _repo;

  GetMessagesForChatUseCase(this._repo);

  @override
  Future<UseCaseResult<Stream<List<BaseConversation>>>> execute(
      GetMessagesForChatUseCaseParams params) async {
    try {
      var conversation = _repo.observeConversation(
          sender: params.sender, recipient: params.recipient);
      return UseCaseResult<Stream<List<BaseConversation>>>.success(
          conversation.asBroadcastStream());
    } on Exception {
      return UseCaseResult.error("Unable to send message");
    }
  }
}
