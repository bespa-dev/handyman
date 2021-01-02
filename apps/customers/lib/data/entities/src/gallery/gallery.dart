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

part 'gallery.g.dart';

@HiveType(typeId: 3)
@JsonSerializable(fieldRename: FieldRename.snake)
class Gallery extends BaseGallery {
  @HiveField(0)
  @override
  final String userId;

  @HiveField(1)
  @override
  final String imageUrl;

  @HiveField(2)
  @override
  final String id;

  @HiveField(3)
  @override
  final String createdAt;

  Gallery({
    this.id,
    this.createdAt,
    this.userId,
    this.imageUrl,
  });

  @override
  get model => this;

  @override
  Map<String, dynamic> toJson() => _$GalleryToJson(this);

  factory Gallery.fromJson(Map<String, dynamic> json) =>
      _$GalleryFromJson(json);
}
