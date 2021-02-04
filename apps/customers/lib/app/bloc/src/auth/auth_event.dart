/*
 * Copyright (c) 2021.
 * This application is owned by HandyMan LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */

import 'package:super_enum/super_enum.dart';

part 'auth_event.super.dart';

@superEnum
enum _AuthEvent {
  @Data(
    fields: [
      DataField<String>('email'),
      DataField<String>('password'),
    ],
  )
  EmailSignInEvent,
  @Data(
    fields: [
      DataField<String>('username'),
      DataField<String>('email'),
      DataField<String>('password'),
    ],
  )
  EmailSignUpEvent,
  @Data(
    fields: [
      DataField<String>('email'),
    ],
  )
  ResetPasswordEvent,
  @object
  FederatedOAuthEvent,
  @object
  AuthSignOutEvent,
  @object
  ObserveMessageEvent,
  @object
  ObserveAuthStatetEvent,
}
