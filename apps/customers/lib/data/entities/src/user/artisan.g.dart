// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artisan.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ArtisanAdapter extends TypeAdapter<Artisan> {
  @override
  final int typeId = 5;

  @override
  Artisan read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Artisan(
      id: fields[10] as String,
      createdAt: fields[11] as String,
      businessId: fields[0] as String,
      category: fields[1] as String,
      startWorkingHours: fields[2] as int,
      endWorkingHours: fields[3] as int,
      bookingsCount: fields[4] as int,
      requests: (fields[5] as List)?.cast<String>(),
      reports: (fields[6] as List)?.cast<String>(),
      isCertified: fields[7] as bool,
      isAvailable: fields[8] as bool,
      isApproved: fields[9] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Artisan obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.businessId)
      ..writeByte(1)
      ..write(obj.category)
      ..writeByte(2)
      ..write(obj.startWorkingHours)
      ..writeByte(3)
      ..write(obj.endWorkingHours)
      ..writeByte(4)
      ..write(obj.bookingsCount)
      ..writeByte(5)
      ..write(obj.requests)
      ..writeByte(6)
      ..write(obj.reports)
      ..writeByte(7)
      ..write(obj.isCertified)
      ..writeByte(8)
      ..write(obj.isAvailable)
      ..writeByte(9)
      ..write(obj.isApproved)
      ..writeByte(10)
      ..write(obj.id)
      ..writeByte(11)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ArtisanAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Artisan _$ArtisanFromJson(Map<String, dynamic> json) {
  return Artisan(
    id: json['id'] as String,
    createdAt: json['created_at'] as String,
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
