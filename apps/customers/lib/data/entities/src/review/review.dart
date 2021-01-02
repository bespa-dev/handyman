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

part 'review.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Review extends BaseReview {
  final String body;
  final String customerId;
  final String artisanId;
  final double rating;

  Review({
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
