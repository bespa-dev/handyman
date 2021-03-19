// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ArtisanServiceAdapter extends TypeAdapter<ArtisanService> {
  @override
  final int typeId = 9;

  @override
  ArtisanService read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ArtisanService(
      id: fields[0] as String,
      category: fields[1] as String,
      name: fields[3] as String,
      price: fields[2] as double,
      artisanId: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ArtisanService obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.category)
      ..writeByte(2)
      ..write(obj.price)
      ..writeByte(3)
      ..write(obj.name)
      ..writeByte(4)
      ..write(obj.artisanId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ArtisanServiceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArtisanService _$ArtisanServiceFromJson(Map<String, dynamic> json) {
  return ArtisanService(
    id: json['id'] as String,
    category: json['category'] as String,
    name: json['name'] as String,
    price: (json['price'] as num)?.toDouble(),
    artisanId: json['artisan_id'] as String,
  );
}

Map<String, dynamic> _$ArtisanServiceToJson(ArtisanService instance) =>
    <String, dynamic>{
      'id': instance.id,
      'category': instance.category,
      'price': instance.price,
      'name': instance.name,
      'artisan_id': instance.artisanId,
    };
