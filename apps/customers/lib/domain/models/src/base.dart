/*
 * Copyright (c) 2021.
 * This application is owned by HandyMan LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */

/// base class for all data models
abstract class BaseModel {

  String id;
  int createdAt;

  dynamic get model;

  Map<String, dynamic> toJson();

  @override
  String toString() => this.toJson().toString();
}
