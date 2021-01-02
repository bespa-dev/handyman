// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Conversation _$ConversationFromJson(Map<String, dynamic> json) {
  return Conversation(
    author: json['author'] as String,
    recipient: json['recipient'] as String,
    body: json['body'] as String,
    format: json['format'] as String,
  )
    ..id = json['id'] as String
    ..createdAt = json['createdAt'] as int;
}

Map<String, dynamic> _$ConversationToJson(Conversation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt,
      'author': instance.author,
      'recipient': instance.recipient,
      'body': instance.body,
      'format': instance.format,
    };
