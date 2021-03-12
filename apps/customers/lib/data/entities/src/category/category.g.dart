// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ServiceCategoryAdapter extends TypeAdapter<ServiceCategory> {
  @override
  final int typeId = 1;

  @override
  ServiceCategory read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ServiceCategory(
      id: fields[3] as String,
      createdAt: fields[4] as String,
      name: fields[0] as String,
      avatar: fields[1] as String,
      groupName: fields[2] as String,
      parent: fields[6] as String,
      hasServices: fields[5] as bool,
      issues: (fields[7] as List)?.cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, ServiceCategory obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.avatar)
      ..writeByte(2)
      ..write(obj.groupName)
      ..writeByte(3)
      ..write(obj.id)
      ..writeByte(4)
      ..write(obj.createdAt)
      ..writeByte(5)
      ..write(obj.hasServices)
      ..writeByte(6)
      ..write(obj.parent)
      ..writeByte(7)
      ..write(obj.issues);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ServiceCategoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServiceCategory _$ServiceCategoryFromJson(Map<String, dynamic> json) {
  return ServiceCategory(
    id: json['id'] as String,
    createdAt: json['created_at'] as String,
    name: json['name'] as String,
    avatar: json['avatar'] as String,
    groupName: json['group_name'] as String,
    parent: json['parent'] as String,
    hasServices: json['has_services'] as bool,
    issues: (json['issues'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$ServiceCategoryToJson(ServiceCategory instance) =>
    <String, dynamic>{
      'name': instance.name,
      'avatar': instance.avatar,
      'group_name': instance.groupName,
      'id': instance.id,
      'created_at': instance.createdAt,
      'has_services': instance.hasServices,
      'parent': instance.parent,
      'issues': instance.issues,
    };
