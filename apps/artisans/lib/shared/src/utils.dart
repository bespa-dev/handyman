/*
 * Copyright (c) 2021.
 * This application is owned by HandyMan LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */

import 'constants.dart';

class RefUtils {
  static const String kBookingRef = "bookings";
  static const String kConversationRef = "conversations";
  static const String kArtisanRef = "artisans";
  static const String kCustomerRef = "customers";
  static const String kGalleryRef = "galleries";
  static const String kCategoryRef = "categories";
  static const String kReviewRef = "reviews";
  static const String kBusinessRef = "businesses";
  static String kBucketRef = kAppName.toLowerCase().replaceAll(" ", "_");
}

class PrefUtils {
  static const String kUserId = "user_id";
  static const String kEmergencyContact = "emergency_contact";
  static const String kTheme = "theme_mode";
  static const String kShowSplash = "show_splash";
  static const String kStandardView = "use_standard_view";
}
