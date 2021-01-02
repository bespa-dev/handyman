/*
 * Copyright (c) 2021.
 * This application is owned by HandyMan LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */

import 'package:flutter/foundation.dart';
import 'package:lite/domain/models/models.dart';
import 'package:meta/meta.dart';

/// base local datasource class
abstract class BaseLocalDatasource extends ChangeNotifier {
  /// observe current user
  Stream<BaseUser> currentUser();

  /// Get all [BaseArtisan]
  Stream<List<BaseArtisan>> observeArtisans({@required String category});

  /// Get an [BaseArtisan] by [id]
  Stream<BaseArtisan> observeArtisanById({@required String id});

  /// Get [BaseUser] by [id]
  Stream<BaseUser> observeCustomerById({@required String id});

  /// Get an [BaseArtisan] by [id]
  Future<BaseArtisan> getArtisanById({@required String id});

  /// Get [BaseUser] by [id]
  Future<BaseUser> getCustomerById({@required String id});

  /// Get all [BaseServiceCategory]
  Stream<List<BaseServiceCategory>> observeCategories({
    @required ServiceCategoryGroup categoryGroup,
  });

  /// Get [BaseServiceCategory] by [id]
  Stream<BaseServiceCategory> observeCategoryById({String id});

  /// Get [BaseReview] for [Artisan]
  Stream<List<BaseReview>> observeReviewsForArtisan(String id);

  /// Get [BaseReview] for [Customer] by [id]
  Stream<List<BaseReview>> observeReviewsByCustomer(String id);

  /// Delete a [CustomerReview] by [id]
  Future<void> deleteReviewById({String id, String customerId});

  /// Send a [CustomerReview]
  Future<void> sendReview({String message, String reviewer, String artisan});

  Future<void> updateBooking({@required BaseBooking booking});

  Future<void> deleteBooking({@required BaseBooking booking});

  /// Get [Booking] for [Artisan] by [id]
  Stream<List<BaseBooking>> observeBookingsForArtisan(String id);

  /// Get [Booking] for [Customer] by [id]
  Stream<List<BaseBooking>> observeBookingsForCustomer(String id);

  /// Get [Booking] for [Artisan] & [Customer]
  Stream<List<BaseBooking>> bookingsForCustomerAndArtisan(
      String customerId, String artisanId);

  /// Get [BaseGallery] images for [BaseArtisan] by [userId]
  Stream<List<BaseGallery>> getPhotosForArtisan({@required String userId});

  /// Upload business [images]
  Future<void> uploadBusinessPhotos({
    @required String userId,
    @required List<String> images,
  });

  /// Search for any [BaseArtisan]
  Future<List<BaseUser>> searchFor({@required String query, String categoryId});

  /// Get [BaseConversation] between [sender] & [recipient]
  Stream<List<BaseConversation>> observeConversation(
      {@required String sender, @required String recipient});

  /// Send [BaseConversation]
  Future<void> sendMessage({@required BaseConversation conversation});

  /// Update [BaseUser] profile information
  Future<void> updateUser(BaseUser user);

  /// Get [BaseBooking] by [id]
  Stream<BaseBooking> getBookingById({@required String id});

  /// Get [BaseBooking] by [dueDate]
  Stream<List<BaseBooking>> getBookingsByDueDate(
      {@required String dueDate, @required String artisanId});

  /// Request [Booking] for an [Artisan]
  Future<void> requestBooking({
    @required String artisan,
    @required String customer,
    @required String category,
    @required String description,
    @required String image,
    @required double lat,
    @required double lng,
  });

  Future<void> updateCategory({@required BaseServiceCategory category});

  Future<void> updateGallery({@required BaseGallery gallery});

  Future<void> updateReview({@required BaseReview review});
}