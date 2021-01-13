/*
 * Copyright (c) 2021.
 * This application is owned by HandyMan LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */

abstract class BaseLocationMetadata {
  double lat;
  double lng;
  String name;

  Map<String, dynamic> toJson();

  @override
  String toString() => this.toJson().toString();

  BaseLocationMetadata copyWith({
    String name,
    double lat,
    double lng,
  });
}
