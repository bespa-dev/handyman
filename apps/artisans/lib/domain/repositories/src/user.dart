/*
 * Copyright (c) 2021.
 * This application is owned by HandyMan LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */

import 'package:handyman/domain/models/models.dart';
import 'package:meta/meta.dart';

/// base user repository class
abstract class BaseUserRepository implements Exposable {
  /// Update [BaseUser] profile information
  Future<void> updateUser({@required BaseUser user});

  /// Get [Booking] for [Artisan] by [id]
  Stream<List<BaseBooking>> getBookingsForArtisan(String id);

  /// Get [Booking] for [Customer] by [id]
  Stream<List<BaseBooking>> getBookingsForCustomer(String id);

  /// Get [BaseReview] for [Artisan]
  Stream<List<BaseReview>> getReviewsForArtisan(String id);

  /// Get [BaseReview] for [Customer] by [id]
  Stream<List<BaseReview>> getReviewsByCustomer(String id);

  /// observe current user
  Stream<BaseUser> currentUser();

  /// Get all [BaseArtisan]
  Stream<List<BaseArtisan>> getArtisans({@required String category});

  /// Get an [BaseArtisan] by [id]
  Stream<BaseArtisan> getArtisanById({@required String id});

  /// Get [BaseUser] by [id]
  Stream<BaseUser> getCustomerById({@required String id});
}
