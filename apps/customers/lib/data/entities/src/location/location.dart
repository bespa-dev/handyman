import 'package:lite/domain/models/models.dart';
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

  const LocationMetadata({@required this.lat, @required this.lng})
      : super(lat: lat, lng: lng);

  @override
  String toString() => this.toJson().toString();

  factory LocationMetadata.fromJson(Map<String, dynamic> json) =>
      _$LocationMetadataFromJson(json);

  Map<String, dynamic> toJson() => _$LocationMetadataToJson(this);

  static toJsonFormat(LocationMetadata instance) =>
      _$LocationMetadataToJson(instance);

  static LocationMetadata fromJsonFormat(Map<String, dynamic> json) =>
      _$LocationMetadataFromJson(json);
}
