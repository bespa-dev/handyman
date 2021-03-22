import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:lite/domain/models/models.dart';
import 'package:meta/meta.dart';

part 'location.g.dart';

class LocationMetadataSerializer
    implements JsonConverter<BaseLocationMetadata, Map<String, dynamic>> {
  const LocationMetadataSerializer();

  @override
  BaseLocationMetadata fromJson(Map<String, dynamic> json) =>
      LocationMetadata.fromJson(json);

  @override
  Map<String, dynamic> toJson(BaseLocationMetadata instance) =>
      instance.toJson();
}

@HiveType(typeId: 8)
@JsonSerializable(genericArgumentFactories: true)
class LocationMetadata extends BaseLocationMetadata {
  @override
  @HiveField(0)
  final double lat;

  @override
  @HiveField(1)
  final double lng;

  @override
  @HiveField(2)
  final String name;

  LocationMetadata({
    @required this.lat,
    @required this.lng,
    this.name = '',
  });

  factory LocationMetadata.fromJson(Map<String, dynamic> json) =>
      _$LocationMetadataFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$LocationMetadataToJson(this);

  @override
  BaseLocationMetadata copyWith({String name, double lat, double lng}) =>
      LocationMetadata(
        lat: lat ??= this.lat,
        lng: lng ??= this.lng,
        name: name ??= this.name,
      );
}
