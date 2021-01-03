/*
 * Copyright (c) 2021.
 * This application is owned by HandyMan LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */

import 'package:super_enum/super_enum.dart';

part 'user_event.super.dart';

@superEnum
enum _UserEvent {
  @object
  CurrentUserEvent,
  @generic
  @Data(
    fields: [DataField<Generic>("user")],
  )
  UpdateUserEvent,
  @Data(
    fields: [DataField<String>("id")],
  )
  GetArtisanByIdEvent,
  @Data(
    fields: [DataField<String>("id")],
  )
  ObserveArtisanByIdEvent,
  @Data(
    fields: [DataField<String>("id")],
  )
  GetCustomerByIdEvent,
  @Data(
    fields: [DataField<String>("id")],
  )
  ObserveCustomerByIdEvent,
  @Data(
    fields: [DataField<String>("category")],
  )
  ObserveArtisansEvent,
}
