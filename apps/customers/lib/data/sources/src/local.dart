/*
 * Copyright (c) 2021.
 * This application is owned by HandyMan LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lite/data/entities/entities.dart';
import 'package:lite/shared/shared.dart';

/// Read more -> https://docs.hivedb.dev/
Future registerHiveDatabase() async {
  /// initialize hive
  await Hive.initFlutter();

  /// register adapters
  Hive
    ..registerAdapter(BookingAdapter())
    ..registerAdapter(ServiceCategoryAdapter())
    ..registerAdapter(ConversationAdapter())
    ..registerAdapter(GalleryAdapter())
    ..registerAdapter(ReviewAdapter())
    ..registerAdapter(ArtisanAdapter())
    ..registerAdapter(CustomerAdapter());

  /// open boxes
  await Hive.openBox<Booking>(RefUtils.kBookingRef);
  await Hive.openBox<ServiceCategory>(RefUtils.kCategoryRef);
  await Hive.openBox<Conversation>(RefUtils.kConversationRef);
  await Hive.openBox<Gallery>(RefUtils.kGalleryRef);
  await Hive.openBox<Review>(RefUtils.kReviewRef);
  await Hive.openBox<Artisan>(RefUtils.kArtisanRef);
  await Hive.openBox<Customer>(RefUtils.kCustomerRef);
}
