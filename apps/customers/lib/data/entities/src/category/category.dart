/*
 * Copyright (c) 2021.
 * This application is owned by HandyMan LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */

import 'package:lite/domain/models/models.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

@HiveType(typeId: 1)
@JsonSerializable(fieldRename: FieldRename.snake)
class ServiceCategory extends BaseServiceCategory {
  @HiveField(0)
  @override
  final String name;

  @HiveField(1)
  @override
  final String avatar;

  @HiveField(2)
  @override
  final String groupName;

  @HiveField(3)
  @override
  final String id;

  @HiveField(4)
  @override
  final String createdAt;

  @HiveField(5)
  @override
  final bool hasServices;

  ServiceCategory({
    this.id,
    this.createdAt,
    this.name,
    this.avatar,
    this.groupName,
    this.hasServices = false,
  });

  @override
  get model => this;

  factory ServiceCategory.fromJson(Map<String, dynamic> json) =>
      _$ServiceCategoryFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ServiceCategoryToJson(this);
}
