/*
 * Copyright (c) 2021.
 * This application is owned by HandyMan LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */

import 'package:handyman/app/bloc/bloc.dart';
import 'package:handyman/domain/models/models.dart';
import 'package:handyman/domain/repositories/repositories.dart';
import 'package:handyman/domain/usecases/usecases.dart';
import 'package:meta/meta.dart';

import 'conversation_event.dart';

class ConversationBloc extends BaseBloc<ConversationEvent> {
  ConversationBloc({@required BaseConversationRepository repo})
      : assert(repo != null),
        _repo = repo;

  final BaseConversationRepository _repo;

  @override
  Stream<BlocState> mapEventToState(ConversationEvent event) async* {
    yield* event.when(
      sendMessage: (e) => _mapEventToState(e),
      getMessages: (e) => _mapEventToState(e),
    );
  }

  Stream<BlocState> _mapEventToState(ConversationEvent event) async* {
    yield BlocState.loadingState();
    if (event is SendMessage) {
      var result =
          await SendMessageUseCase(_repo).execute(SendMessageUseCaseParams(
        sender: event.sender,
        recipient: event.recipient,
        message: event.message,
        type: event.type,
      ));
      if (result is UseCaseResultSuccess) {
        yield BlocState.successState();
      } else {
        yield BlocState.errorState(failure: 'Failed to send message');
      }
    } else if (event is GetMessages) {
      var result = await GetMessagesForChatUseCase(_repo)
          .execute(GetMessagesForChatUseCaseParams(
        sender: event.sender,
        recipient: event.recipient,
      ));

      if (result is UseCaseResultSuccess<Stream<List<BaseConversation>>>) {
        yield BlocState<Stream<List<BaseConversation>>>.successState(
            data: result.value);
      } else {
        yield BlocState.errorState(failure: 'Failed to send message');
      }
    }
  }
}
