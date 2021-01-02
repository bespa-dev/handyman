// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artisan.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Artisan _$ArtisanFromJson(Map<String, dynamic> json) {
  return Artisan(
    id: json['id'] as String,
    createdAt: json['created_at'] as int,
    businessId: json['business_id'] as String,
    category: json['category'] as String,
    startWorkingHours: json['start_working_hours'] as int,
    endWorkingHours: json['end_working_hours'] as int,
    bookingsCount: json['bookings_count'] as int,
    requests: (json['requests'] as List)?.map((e) => e as String)?.toList(),
    reports: (json['reports'] as List)?.map((e) => e as String)?.toList(),
    isCertified: json['is_certified'] as bool,
    isAvailable: json['is_available'] as bool,
    isApproved: json['is_approved'] as bool,
  )
    ..name = json['name'] as String
    ..email = json['email'] as String
    ..avatar = json['avatar'] as String
    ..token = json['token'] as String
    ..phone = json['phone'] as String;
}

Map<String, dynamic> _$ArtisanToJson(Artisan instance) => <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'avatar': instance.avatar,
      'token': instance.token,
      'phone': instance.phone,
      'business_id': instance.businessId,
      'category': instance.category,
      'start_working_hours': instance.startWorkingHours,
      'end_working_hours': instance.endWorkingHours,
      'bookings_count': instance.bookingsCount,
      'requests': instance.requests,
      'reports': instance.reports,
      'is_certified': instance.isCertified,
      'is_available': instance.isAvailable,
      'is_approved': instance.isApproved,
      'id': instance.id,
      'created_at': instance.createdAt,
    };
