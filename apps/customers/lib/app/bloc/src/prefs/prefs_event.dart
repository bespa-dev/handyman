/*
 * Copyright (c) 2021.
 * This application is owned by HandyMan LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */

import 'package:super_enum/super_enum.dart';

part 'prefs_event.super.dart';

@superEnum
enum _PrefsEvent {
  @object
  GetUserIdEvent,
  @object
  GetHomeAddressEvent,
  @object
  GetWorkAddressEvent,
  @object
  GetThemeEvent,
  @object
  GetContactEvent,
  @object
  ObserveThemeEvent,
  @object
  GetStandardViewEvent,
  @object
  PrefsSignOutEvent,
  @Data(fields: [DataField<bool>("lightTheme")])
  SaveLightThemeEvent,
  @Data(fields: [DataField<bool>("standardView")])
  SaveStandardViewEvent,
  @Data(fields: [DataField<String>("contact")])
  SaveContactEvent,
  @Data(fields: [DataField<String>("id")])
  SaveUserIdEvent,
  @Data(fields: [DataField<String>("address")])
  SaveHomeAddressEvent,
  @Data(fields: [DataField<String>("address")])
  SaveWorkAddressEvent,
}
