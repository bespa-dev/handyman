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
      startWorkingHours: fields[2] as String,
      endWorkingHours: fields[3] as String,
      name: fields[16] as String,
      token: fields[12] as String,
      phone: fields[13] as String,
      avatar: fields[14] as String,
      email: fields[15] as String,
      businessId: fields[0] as String,
      birthCert: fields[19] as String,
      nationalId: fields[20] as String,
      category: fields[1] as String,
      categoryGroup: fields[18] as String,
      rating: fields[17] as double,
      bookingsCount: fields[4] as int,
      requests: (fields[5] as List)?.cast<String>(),
      reports: (fields[6] as List)?.cast<String>(),
      services: (fields[21] as List)?.cast<BaseArtisanService>(),
      isAvailable: fields[8] as bool,
      isApproved: fields[9] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Artisan obj) {
    writer
      ..writeByte(22)
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
      ..writeByte(8)
      ..write(obj.isAvailable)
      ..writeByte(9)
      ..write(obj.isApproved)
      ..writeByte(10)
      ..write(obj.id)
      ..writeByte(11)
      ..write(obj.createdAt)
      ..writeByte(12)
      ..write(obj.token)
      ..writeByte(13)
      ..write(obj.phone)
      ..writeByte(14)
      ..write(obj.avatar)
      ..writeByte(15)
      ..write(obj.email)
      ..writeByte(16)
      ..write(obj.name)
      ..writeByte(17)
      ..write(obj.rating)
      ..writeByte(18)
      ..write(obj.categoryGroup)
      ..writeByte(19)
      ..write(obj.birthCert)
      ..writeByte(20)
      ..write(obj.nationalId)
      ..writeByte(21)
      ..write(obj.services)
      ..writeByte(7)
      ..write(obj.isCertified);
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
    startWorkingHours: json['start_working_hours'] as String,
    endWorkingHours: json['end_working_hours'] as String,
    category: json['category'] as String,
    categoryGroup: json['category_group'] as String,
    name: json['name'] as String,
    token: json['token'] as String,
    phone: json['phone'] as String,
    avatar: json['avatar'] as String,
    email: json['email'] as String,
    birthCert: json['birth_cert'] as String,
    businessId: json['business_id'] as String,
    nationalId: json['national_id'] as String,
    rating: json['rating'] as double,
    bookingsCount: json['bookings_count'] as int,
    requests: json['requests'] as List<String>,
    reports: json['reports'] as List<String>,
    services: json['services'] == null
        ? <BaseArtisanService>[]
        : (json['services'] as List<dynamic>)
            .map((e) => ArtisanService.fromJson(e))
            .toList(),
    isAvailable: json['available'] as bool,
    isApproved: json['approved'] as bool,
  );
}

Map<String, dynamic> _$ArtisanToJson(Artisan instance) => <String, dynamic>{
      'start_working_hours': instance.startWorkingHours,
      'end_working_hours': instance.endWorkingHours,
      'category': instance.category,
      'category_group': instance.categoryGroup,
      'name': instance.name,
      'token': instance.token,
      'phone': instance.phone,
      'avatar': instance.avatar,
      'email': instance.email,
      'birth_cert': instance.birthCert,
      'business_id': instance.businessId,
      'national_id': instance.nationalId,
      'id': instance.id,
      'created_at': instance.createdAt,
      'rating': instance.rating,
      'bookings_count': instance.bookingsCount,
      'requests': instance.requests,
      'reports': instance.reports,
      'services': instance.services,
      'available': instance.isAvailable,
      'approved': instance.isApproved,
    };
