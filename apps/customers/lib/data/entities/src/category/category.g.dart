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
    );
  }

  @override
  void write(BinaryWriter writer, ServiceCategory obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.avatar)
      ..writeByte(2)
      ..write(obj.groupName)
      ..writeByte(3)
      ..write(obj.id)
      ..writeByte(4)
      ..write(obj.createdAt);
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
