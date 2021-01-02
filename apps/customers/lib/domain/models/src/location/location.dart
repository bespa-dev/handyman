/*
 * Copyright (c) 2021.
 * This application is owned by HandyMan LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'location.g.dart';

/// location metadata class
@JsonSerializable()
class LocationMetadata {
  final double lat;
  final double lng;

  const LocationMetadata({@required this.lat, @required this.lng});

  factory LocationMetadata.fromJson(Map<String, dynamic> json) =>
      _$LocationMetadataFromJson(json);

  Map<String, dynamic> toJson() => _$LocationMetadataToJson(this);
}
