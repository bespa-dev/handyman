// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Review _$ReviewFromJson(Map<String, dynamic> json) {
  return Review(
    id: json['id'] as String,
    createdAt: json['created_at'] as int,
    body: json['body'] as String,
    customerId: json['customer_id'] as String,
    artisanId: json['artisan_id'] as String,
    rating: (json['rating'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$ReviewToJson(Review instance) => <String, dynamic>{
      'body': instance.body,
      'customer_id': instance.customerId,
      'artisan_id': instance.artisanId,
      'rating': instance.rating,
      'id': instance.id,
      'created_at': instance.createdAt,
    };
