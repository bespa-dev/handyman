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
  /// https://stackoverflow.com/questions/55552230/flutter-validate-a-phone-number-using-regex/55552272
  static bool validatePhoneNumber(String phoneNumber) {
    var pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    var regExp = RegExp(pattern);
    if (phoneNumber.isEmpty) {
      return false;
    } else if (!regExp.hasMatch(phoneNumber)) {
      return false;
    }
    return true;
  }

  /// validate user [pwd]
  static bool validatePassword(String pwd) => pwd.isNotEmpty && pwd.length >= 6;
}
