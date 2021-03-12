/*
 * Copyright (c) 2021.
 * This application is owned by HandyMan LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */

import 'package:super_enum/super_enum.dart';

part 'category_event.super.dart';

@superEnum
enum _CategoryEvent {
  @generic
  @Data(
    fields: [
      DataField<Generic>('group'),
    ],
  )
  ObserveAllCategories,
  @Data(
    fields: [
      DataField<String>('id'),
    ],
  )
  ObserveCategoryById,
}
