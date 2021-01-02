// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversation.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ConversationAdapter extends TypeAdapter<Conversation> {
  @override
  final int typeId = 2;

  @override
  Conversation read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Conversation(
      createdAt: fields[5] as String,
      id: fields[4] as String,
      author: fields[0] as String,
      recipient: fields[1] as String,
      body: fields[2] as String,
      format: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Conversation obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.author)
      ..writeByte(1)
      ..write(obj.recipient)
      ..writeByte(2)
      ..write(obj.body)
      ..writeByte(3)
      ..write(obj.format)
      ..writeByte(4)
      ..write(obj.id)
      ..writeByte(5)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ConversationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Conversation _$ConversationFromJson(Map<String, dynamic> json) {
  return Conversation(
    createdAt: json['createdAt'] as String,
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
