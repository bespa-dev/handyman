// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Conversation _$ConversationFromJson(Map<String, dynamic> json) {
  return Conversation(
    createdAt: json['createdAt'] as int,
    id: json['id'] as String,
    author: json['author'] as String,
    recipient: json['recipient'] as String,
    body: json['body'] as String,
    format: json['format'] as String,
  );
}

Map<String, dynamic> _$ConversationToJson(Conversation instance) =>
    <String, dynamic>{
      'author': instance.author,
      'recipient': instance.recipient,
      'body': instance.body,
      'format': instance.format,
      'id': instance.id,
      'createdAt': instance.createdAt,
    };
