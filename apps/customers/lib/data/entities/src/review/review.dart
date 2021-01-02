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

part 'review.g.dart';

@HiveType(typeId: 4)
@JsonSerializable(fieldRename: FieldRename.snake)
class Review extends BaseReview {
  @HiveField(0)
  @override
  final String body;

  @HiveField(1)
  @override
  final String customerId;

  @HiveField(2)
  @override
  final String artisanId;

  @HiveField(3)
  @override
  final double rating;

  @HiveField(4)
  @override
  final String id;

  @HiveField(5)
  @override
  final int createdAt;

  Review({
    this.id,
    this.createdAt,
    this.body,
    this.customerId,
    this.artisanId,
    this.rating,
  });

  @override
  get model => this;

  @override
  Map<String, dynamic> toJson() => _$ReviewToJson(this);

  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);
}
