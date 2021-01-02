// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServiceCategory _$ServiceCategoryFromJson(Map<String, dynamic> json) {
  return ServiceCategory(
    id: json['id'] as String,
    createdAt: json['createdAt'] as int,
    name: json['name'] as String,
    avatar: json['avatar'] as String,
    groupName: json['groupName'] as String,
  );
}

Map<String, dynamic> _$ServiceCategoryToJson(ServiceCategory instance) =>
    <String, dynamic>{
      'name': instance.name,
      'avatar': instance.avatar,
      'groupName': instance.groupName,
      'id': instance.id,
      'createdAt': instance.createdAt,
    };
