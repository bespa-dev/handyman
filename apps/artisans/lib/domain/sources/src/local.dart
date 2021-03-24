/*
 * Copyright (c) 2021.
 * This application is owned by HandyMan LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */

import 'package:flutter/foundation.dart';
import 'package:handyman/domain/models/models.dart';
import 'package:meta/meta.dart';

/// base local datasource class
abstract class BaseLocalDatasource extends ChangeNotifier {
  /// observe current user
  Stream<BaseArtisan> currentUser();

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
  Future<void> deleteReviewById({String id});

  /// Send a [CustomerReview]
  Future<void> sendReview({@required BaseReview review});

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
  Future<void> uploadBusinessPhotos({@required List<BaseGallery> galleryItems});

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

  /// Request [BaseBooking] for an [Artisan]
  Future<void> requestBooking({@required BaseBooking booking});

  Future<void> updateCategory({@required BaseServiceCategory category});

  Future<void> updateGallery({@required BaseGallery gallery});

  Future<void> updateReview({@required BaseReview review});

  Future<List<BaseBusiness>> getBusinessesForArtisan(
      {@required String artisan});

  Future<void> updateBusiness({@required BaseBusiness business});

  Future<BaseBusiness> getBusinessById({@required String id});

  Stream<BaseBusiness> observeBusinessById({@required String id});

  Future<List<BaseArtisanService>> getArtisanServices({@required String id});

  Future<BaseArtisanService> getArtisanServiceById({@required String id});

  Future<List<BaseArtisanService>> getArtisanServicesByCategory(
      {@required String categoryId});

  Future<void> updateArtisanService(
      {@required String id, @required BaseArtisanService artisanService});

  Future<void> resetAllPrices();
}
