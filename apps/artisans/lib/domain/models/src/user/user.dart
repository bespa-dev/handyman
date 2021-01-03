/*
 * Copyright (c) 2021.
 * This application is owned by HandyMan LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */

import 'package:handyman/domain/models/models.dart' show BaseModel;

/// base user class
abstract class BaseUser extends BaseModel {
  String name;
  String email;
  String avatar;
  String token;
  String phone;

  BaseUser copyWith({
    String name,
    String email,
    String avatar,
    String token,
    String phone,
  });
}
