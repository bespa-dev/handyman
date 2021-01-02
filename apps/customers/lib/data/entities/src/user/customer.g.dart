// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Customer _$CustomerFromJson(Map<String, dynamic> json) {
  return Customer(
    name: json['name'] as String,
    email: json['email'] as String,
    avatar: json['avatar'] as String,
    token: json['token'] as String,
    phone: json['phone'] as String,
    id: json['id'] as String,
    createdAt: json['createdAt'] as int,
  );
}

Map<String, dynamic> _$CustomerToJson(Customer instance) => <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'avatar': instance.avatar,
      'token': instance.token,
      'phone': instance.phone,
      'id': instance.id,
      'createdAt': instance.createdAt,
    };
