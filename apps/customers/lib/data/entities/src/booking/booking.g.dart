// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Booking _$BookingFromJson(Map<String, dynamic> json) {
  return Booking(
    id: json['id'] as String,
    createdAt: json['created_at'] as int,
    customerId: json['customer_id'] as String,
    artisanId: json['artisan_id'] as String,
    category: json['category'] as String,
    imageUrl: json['image_url'] as String,
    description: json['description'] as String,
    position: json['position'] == null
        ? null
        : LocationMetadata.fromJson(json['position'] as Map<String, dynamic>),
    cost: (json['cost'] as num)?.toDouble(),
    progress: (json['progress'] as num)?.toDouble(),
    dueDate: json['due_date'] as int,
  );
}

Map<String, dynamic> _$BookingToJson(Booking instance) => <String, dynamic>{
      'customer_id': instance.customerId,
      'artisan_id': instance.artisanId,
      'category': instance.category,
      'image_url': instance.imageUrl,
      'description': instance.description,
      'position': instance.position,
      'cost': instance.cost,
      'progress': instance.progress,
      'due_date': instance.dueDate,
      'id': instance.id,
      'created_at': instance.createdAt,
    };
