import 'package:handyman/domain/models/models.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'location.g.dart';

@HiveType(typeId: 8)
@JsonSerializable()
class LocationMetadata extends BaseLocationMetadata {
  @HiveField(0)
  final double lat;

  @HiveField(1)
  final double lng;

  @HiveField(2)
  final String name;

  LocationMetadata({
    @required this.lat,
    @required this.lng,
    this.name = "",
  });

  factory LocationMetadata.fromJson(Map<String, dynamic> json) =>
      _$LocationMetadataFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$LocationMetadataToJson(this);

  // static toJsonFormat(LocationMetadata instance) =>
  //     _$LocationMetadataToJson(instance);
  //
  // static LocationMetadata fromJsonFormat(Map<String, dynamic> json) =>
  //     _$LocationMetadataFromJson(json);

  @override
  BaseLocationMetadata copyWith({String name, double lat, double lng}) =>
      LocationMetadata(
        lat: lat ??= this.lat,
        lng: lng ??= this.lng,
        name: name ??= this.name,
      );
}
