/*
 * Copyright (c) 2021.
 * This application is owned by HandyMan LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */

import 'package:lite/domain/models/models.dart';
import 'package:meta/meta.dart';

/// base user repository class
abstract class BaseUserRepository implements Exposable {
  /// Update [BaseUser] profile information
  Future<void> updateUser({@required BaseUser user});

  /// Get [Booking] for [Artisan] by [id]
  Stream<List<BaseBooking>> observeBookingsForArtisan(String id);

  /// Get [Booking] for [Customer] by [id]
  Stream<List<BaseBooking>> observeBookingsForCustomer(String id);

  /// Get [BaseReview] for [Artisan]
  Stream<List<BaseReview>> observeReviewsForArtisan(String id);

  /// Get [BaseReview] for [Customer] by [id]
  Stream<List<BaseReview>> observeReviewsByCustomer(String id);

  /// observe current user
  Stream<BaseUser> currentUser();

  /// Get all [BaseArtisan]
  Stream<List<BaseArtisan>> observeArtisans({@required String category});

  /// Get an [BaseArtisan] by [id]
  Stream<BaseArtisan> observeArtisanById({@required String id});

  /// Get an [BaseArtisan] by [id]
  Future<BaseArtisan> getArtisanById({@required String id});

  /// Get [BaseUser] by [id]
  Stream<BaseUser> observeCustomerById({@required String id});

  /// Get [BaseUser] by [id]
  Future<BaseUser> getCustomerById({@required String id});
}
