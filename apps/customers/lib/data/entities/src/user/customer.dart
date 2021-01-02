/*
 * Copyright (c) 2021.
 * This application is owned by HandyMan LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */

import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:lite/domain/models/models.dart';

part 'customer.g.dart';

@HiveType(typeId: 6)
@JsonSerializable()
class Customer extends BaseUser {
  @HiveField(0)
  @override
  final String name;

  @HiveField(1)
  @override
  final String email;

  @HiveField(2)
  @override
  final String avatar;

  @HiveField(3)
  @override
  final String token;

  @HiveField(4)
  @override
  final String phone;

  @HiveField(5)
  @override
  final String id;

  @HiveField(6)
  @override
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
