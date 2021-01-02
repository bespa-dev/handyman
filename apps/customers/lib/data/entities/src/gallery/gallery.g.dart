// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gallery.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GalleryAdapter extends TypeAdapter<Gallery> {
  @override
  final int typeId = 3;

  @override
  Gallery read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Gallery(
      id: fields[2] as String,
      createdAt: fields[3] as String,
      userId: fields[0] as String,
      imageUrl: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Gallery obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.userId)
      ..writeByte(1)
      ..write(obj.imageUrl)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GalleryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Gallery _$GalleryFromJson(Map<String, dynamic> json) {
  return Gallery(
    id: json['id'] as String,
    createdAt: json['created_at'] as String,
    userId: json['user_id'] as String,
    imageUrl: json['image_url'] as String,
  );
}

Map<String, dynamic> _$GalleryToJson(Gallery instance) => <String, dynamic>{
      'user_id': instance.userId,
      'image_url': instance.imageUrl,
      'id': instance.id,
      'created_at': instance.createdAt,
    };
