// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gallery.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Gallery _$GalleryFromJson(Map<String, dynamic> json) {
  return Gallery(
    userId: json['user_id'] as String,
    imageUrl: json['image_url'] as String,
  )
    ..id = json['id'] as String
    ..createdAt = json['created_at'] as int;
}

Map<String, dynamic> _$GalleryToJson(Gallery instance) => <String, dynamic>{
      'id': instance.id,
      'created_at': instance.createdAt,
      'user_id': instance.userId,
      'image_url': instance.imageUrl,
    };
