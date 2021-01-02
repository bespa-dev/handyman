// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gallery.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Gallery _$GalleryFromJson(Map<String, dynamic> json) {
  return Gallery(
    id: json['id'] as String,
    createdAt: json['created_at'] as int,
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
