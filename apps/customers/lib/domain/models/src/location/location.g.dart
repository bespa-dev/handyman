// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocationMetadata _$LocationMetadataFromJson(Map<String, dynamic> json) {
  return LocationMetadata(
    lat: (json['lat'] as num)?.toDouble(),
    lng: (json['lng'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$LocationMetadataToJson(LocationMetadata instance) =>
    <String, dynamic>{
      'lat': instance.lat,
      'lng': instance.lng,
    };
