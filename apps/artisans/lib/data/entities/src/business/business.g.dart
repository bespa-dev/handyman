// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'business.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BusinessAdapter extends TypeAdapter<Business> {
  @override
  final int typeId = 7;

  @override
  Business read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Business(
      id: fields[0] as String,
      createdAt: fields[1] as String,
      docUrl: fields[2] as String,
      artisanId: fields[3] as String,
      name: fields[4] as String,
      location: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Business obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.createdAt)
      ..writeByte(2)
      ..write(obj.docUrl)
      ..writeByte(3)
      ..write(obj.artisanId)
      ..writeByte(4)
      ..write(obj.name)
      ..writeByte(5)
      ..write(obj.location);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BusinessAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Business _$BusinessFromJson(Map<String, dynamic> json) {
  return Business(
    id: json['id'] as String,
    createdAt: json['created_at'] as String,
    docUrl: json['doc_url'] as String,
    artisanId: json['artisan_id'] as String,
    name: json['name'] as String,
    location: json['location'] as String,
  );
}

Map<String, dynamic> _$BusinessToJson(Business instance) => <String, dynamic>{
      'id': instance.id,
      'created_at': instance.createdAt,
      'doc_url': instance.docUrl,
      'artisan_id': instance.artisanId,
      'name': instance.name,
      'location': instance.location,
    };
