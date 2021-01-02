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

part 'customer.g.dart';

@JsonSerializable()
class Customer extends BaseUser {
  final String name;
  final String email;
  final String avatar;
  final String token;
  final String phone;
  final String id;
  final int createdAt;

  Customer({
    this.name,
    this.email,
    this.avatar,
    this.token,
    this.phone,
    this.id,
    this.createdAt,
  });

  @override
  get model => this;

  @override
  Map<String, dynamic> toJson() => _$CustomerToJson(this);

  factory Customer.fromJson(Map<String, dynamic> json) =>
      _$CustomerFromJson(json);
}
