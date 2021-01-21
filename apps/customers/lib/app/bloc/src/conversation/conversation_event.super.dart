// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: return_of_invalid_type, constant_identifier_names, prefer_const_constructors_in_immutables, unnecessary_this, sort_unnamed_constructors_first, join_return_with_assignment, missing_return, lines_longer_than_80_chars

part of 'conversation_event.dart';

// **************************************************************************
// SuperEnumGenerator
// **************************************************************************

@immutable
abstract class ConversationEvent<T> extends Equatable {
  const ConversationEvent(this._type);

  factory ConversationEvent.sendMessage(
      {@required String sender,
      @required String recipient,
      @required String message,
      @required T type}) = SendMessage<T>.create;

  factory ConversationEvent.getMessages(
      {@required String sender,
      @required String recipient}) = GetMessages<T>.create;

  final _ConversationEvent _type;

  /// The [when] method is the equivalent to pattern matching.
  /// Its prototype depends on the _ConversationEvent [_type]s defined.
  R when<R extends Object>(
      {@required R Function(SendMessage<T>) sendMessage,
      @required R Function(GetMessages<T>) getMessages}) {
    assert(() {
      if (sendMessage == null || getMessages == null) {
        throw 'check for all possible cases';
      }
      return true;
    }());
    switch (this._type) {
      case _ConversationEvent.SendMessage:
        return sendMessage(this as SendMessage);
      case _ConversationEvent.GetMessages:
        return getMessages(this as GetMessages);
    }
  }

  /// The [whenOrElse] method is equivalent to [when], but doesn't require
  /// all callbacks to be specified.
  ///
  /// On the other hand, it adds an extra orElse required parameter,
  /// for fallback behavior.
  R whenOrElse<R extends Object>(
      {R Function(SendMessage<T>) sendMessage,
      R Function(GetMessages<T>) getMessages,
      @required R Function(ConversationEvent<T>) orElse}) {
    assert(() {
      if (orElse == null) {
        throw 'Missing orElse case';
      }
      return true;
    }());
    switch (this._type) {
      case _ConversationEvent.SendMessage:
        if (sendMessage == null) break;
        return sendMessage(this as SendMessage);
      case _ConversationEvent.GetMessages:
        if (getMessages == null) break;
        return getMessages(this as GetMessages);
    }
    return orElse(this);
  }

  /// The [whenPartial] method is equivalent to [whenOrElse],
  /// but non-exhaustive.
  void whenPartial(
      {void Function(SendMessage<T>) sendMessage,
      void Function(GetMessages<T>) getMessages}) {
    assert(() {
      if (sendMessage == null && getMessages == null) {
        throw 'provide at least one branch';
      }
      return true;
    }());
    switch (this._type) {
      case _ConversationEvent.SendMessage:
        if (sendMessage == null) break;
        return sendMessage(this as SendMessage);
      case _ConversationEvent.GetMessages:
        if (getMessages == null) break;
        return getMessages(this as GetMessages);
    }
  }

  @override
  List<Object> get props => const [];
}

@immutable
abstract class SendMessage<T> extends ConversationEvent<T> {
  const SendMessage(
      {@required this.sender,
      @required this.recipient,
      @required this.message,
      @required this.type})
      : super(_ConversationEvent.SendMessage);

  factory SendMessage.create(
      {@required String sender,
      @required String recipient,
      @required String message,
      @required T type}) = _SendMessageImpl<T>;

  final String sender;

  final String recipient;

  final String message;

  final T type;

  /// Creates a copy of this SendMessage but with the given fields
  /// replaced with the new values.
  SendMessage<T> copyWith(
      {String sender, String recipient, String message, T type});
}

@immutable
class _SendMessageImpl<T> extends SendMessage<T> {
  const _SendMessageImpl(
      {@required this.sender,
      @required this.recipient,
      @required this.message,
      @required this.type})
      : super(
            sender: sender, recipient: recipient, message: message, type: type);

  @override
  final String sender;

  @override
  final String recipient;

  @override
  final String message;

  @override
  final T type;

  @override
  _SendMessageImpl<T> copyWith(
          {Object sender = superEnum,
          Object recipient = superEnum,
          Object message = superEnum,
          Object type = superEnum}) =>
      _SendMessageImpl(
        sender: sender == superEnum ? this.sender : sender as String,
        recipient:
            recipient == superEnum ? this.recipient : recipient as String,
        message: message == superEnum ? this.message : message as String,
        type: type == superEnum ? this.type : type as T,
      );
  @override
  String toString() =>
      'SendMessage(sender: ${this.sender}, recipient: ${this.recipient}, message: ${this.message}, type: ${this.type})';
  @override
  List<Object> get props => [sender, recipient, message, type];
}

@immutable
abstract class GetMessages<T> extends ConversationEvent<T> {
  const GetMessages({@required this.sender, @required this.recipient})
      : super(_ConversationEvent.GetMessages);

  factory GetMessages.create(
      {@required String sender,
      @required String recipient}) = _GetMessagesImpl<T>;

  final String sender;

  final String recipient;

  /// Creates a copy of this GetMessages but with the given fields
  /// replaced with the new values.
  GetMessages<T> copyWith({String sender, String recipient});
}

@immutable
class _GetMessagesImpl<T> extends GetMessages<T> {
  const _GetMessagesImpl({@required this.sender, @required this.recipient})
      : super(sender: sender, recipient: recipient);

  @override
  final String sender;

  @override
  final String recipient;

  @override
  _GetMessagesImpl<T> copyWith(
          {Object sender = superEnum, Object recipient = superEnum}) =>
      _GetMessagesImpl(
        sender: sender == superEnum ? this.sender : sender as String,
        recipient:
            recipient == superEnum ? this.recipient : recipient as String,
      );
  @override
  String toString() =>
      'GetMessages(sender: ${this.sender}, recipient: ${this.recipient})';
  @override
  List<Object> get props => [sender, recipient];
}
