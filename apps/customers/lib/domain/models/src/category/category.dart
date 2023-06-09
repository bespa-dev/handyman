/*
 * Copyright (c) 2021.
 * This application is owned by HandyMan LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */

import 'package:lite/domain/models/models.dart' show BaseModel;
import 'package:super_enum/super_enum.dart';

part 'category.super.dart';

@superEnum
enum _ServiceCategoryGroup {
  @object
  Featured,
  @object
  Popular,
  @object
  MostRated,
  @object
  Recent,
  @object
  Recommended,
}

/// base service category class
abstract class BaseServiceCategory extends BaseModel {
  String name;

  String parent;

  String avatar;

  String groupName; // one of ServiceCategoryGroup

  bool hasServices;

  bool get hasParent;

  List<String> issues;
}

extension CategoryX on ServiceCategoryGroup {
  String name() => toString().replaceAll('()', '');
}
