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

part 'gallery.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Gallery extends BaseGallery {
  final String userId;
  final String imageUrl;

  Gallery({
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
