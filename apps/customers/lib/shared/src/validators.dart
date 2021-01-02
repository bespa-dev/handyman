/*
 * Copyright (c) 2021.
 * This application is owned by HandyMan LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */

import 'package:email_validator/email_validator.dart';

class Validators {
  /// validate user [emailAddress]
  static bool validateEmail(String emailAddress) =>
      EmailValidator.validate(emailAddress);

  /// validate user [phoneNumber]
  static bool validatePhoneNumber(String phoneNumber) {}

  /// validate user [pwd]
  static bool validatePassword(String pwd) => pwd.isNotEmpty && pwd.length >= 6;
}
