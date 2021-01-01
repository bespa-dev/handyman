/*
 * Copyright (c) 2021.
 * This application is owned by HandyMan LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */

import 'dart:io';

import 'package:handyman/domain/models/models.dart';
import 'package:meta/meta.dart';

/// base local datasource class
abstract class BaseLocalDatasource {
  /// observe current user
  Stream<BaseUser> currentUser();

  /// Get all [BaseArtisan]
  Stream<List<BaseArtisan>> getArtisans({@required String category});

  /// Get an [BaseArtisan] by [id]
  Stream<BaseArtisan> getArtisanById({@required String id});

  /// Get [BaseUser] by [id]
  Stream<BaseUser> getCustomerById({@required String id});

  /// Get all [BaseServiceCategory]
  Stream<List<BaseServiceCategory>> getCategories({
    @required ServiceCategoryGroup categoryGroup,
  });

  /// Get [BaseServiceCategory] by [id]
  Stream<BaseServiceCategory> getCategoryById({String id});

  /// Get [BaseReview] for [Artisan]
  Stream<List<BaseReview>> getReviewsForArtisan(String id);

  /// Get [BaseReview] for [Customer] by [id]
  Stream<List<BaseReview>> getReviewsByCustomer(String id);

  /// Delete a [CustomerReview] by [id]
  Future<void> deleteReviewById({String id, String customerId});

  /// Send a [CustomerReview]
  Future<void> sendReview({String message, String reviewer, String artisan});

  Future<void> updateBooking({@required BaseBooking booking});

  Future<void> deleteBooking({@required BaseBooking booking});

  /// Get [Booking] for [Artisan] by [id]
  Stream<List<BaseBooking>> getBookingsForArtisan(String id);

  /// Get [Booking] for [Customer] by [id]
  Stream<List<BaseBooking>> getBookingsForCustomer(String id);

  /// Get [Booking] for [Artisan] & [Customer]
  Stream<List<BaseBooking>> bookingsForCustomerAndArtisan(
      String customerId, String artisanId);

  /// Get [BaseGallery] images for [BaseArtisan] by [userId]
  Stream<List<BaseGallery>> getPhotosForArtisan({@required String userId});

  /// Upload business [images]
  Future<void> uploadBusinessPhotos({
    @required String userId,
    @required List<File> images,
  });

  /// Search for any [BaseArtisan]
  Future<List<BaseUser>> searchFor({@required String value, String categoryId});

  /// Get [BaseConversation] between [sender] & [recipient]
  Stream<List<BaseConversation>> getConversation(
      {@required String sender, @required String recipient});

  /// Send [BaseConversation]
  Future<void> sendMessage({@required BaseConversation conversation});

  /// Update [BaseUser] profile information
  Future<void> updateUser(BaseUser user, {bool sync = true});

  /// Get [BaseBooking] by [id]
  Stream<BaseBooking> getBookingById({String id});

  /// Get [BaseBooking] by [dueDate]
  Stream<List<BaseBooking>> getBookingsByDueDate(
      {@required String dueDate, @required String artisanId});

  /// Request [Booking] for an [Artisan]
  Future<void> requestBooking({
    @required BaseArtisan artisan,
    @required String customer,
    @required String category,
    @required String description,
    @required File image,
    @required double lat,
    @required double lng,
  });
}
