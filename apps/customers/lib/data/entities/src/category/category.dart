/*
 * Copyright (c) 2021.
 * This application is owned by HandyMan LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */

import 'package:json_annotation/json_annotation.dart';
import 'package:lite/domain/models/models.dart';

part 'category.g.dart';

@JsonSerializable()
class ServiceCategory extends BaseServiceCategory {
  final String name;
  final String avatar;
  final String groupName;

  ServiceCategory({
    this.name,
    this.avatar,
    this.groupName,
  });

  @override
  get model => this;

  factory ServiceCategory.fromJson(Map<String, dynamic> json) =>
      _$ServiceCategoryFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ServiceCategoryToJson(this);
}
