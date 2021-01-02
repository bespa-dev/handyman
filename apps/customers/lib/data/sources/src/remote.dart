/*
 * Copyright (c) 2021.
 * This application is owned by HandyMan LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lite/domain/models/models.dart';
import 'package:lite/domain/models/src/booking.dart';
import 'package:lite/domain/models/src/category/category.dart';
import 'package:lite/domain/models/src/conversation/conversation.dart';
import 'package:lite/domain/repositories/repositories.dart';
import 'package:lite/domain/sources/sources.dart';
import 'package:meta/meta.dart';

class FirebaseRemoteDatasource implements BaseRemoteDatasource {
  final BasePreferenceRepository prefsRepo;
  final FirebaseFirestore firestore;

  FirebaseRemoteDatasource(
      {@required this.prefsRepo, @required this.firestore});

  @override
  Stream<List<BaseBooking>> bookingsForCustomerAndArtisan(
      String customerId, String artisanId) {
    // TODO: implement bookingsForCustomerAndArtisan
    throw UnimplementedError();
  }

  @override
  Stream<BaseUser> currentUser() {
    // TODO: implement currentUser
    throw UnimplementedError();
  }

  @override
  Future<void> deleteBooking({BaseBooking booking}) {
    // TODO: implement deleteBooking
    throw UnimplementedError();
  }

  @override
  Future<void> deleteReviewById({String id, String customerId}) {
    // TODO: implement deleteReviewById
    throw UnimplementedError();
  }

  @override
  Future<BaseArtisan> getArtisanById({String id}) {
    // TODO: implement getArtisanById
    throw UnimplementedError();
  }

  @override
  Stream<BaseBooking> getBookingById({String id}) {
    // TODO: implement getBookingById
    throw UnimplementedError();
  }

  @override
  Stream<List<BaseBooking>> getBookingsByDueDate(
      {String dueDate, String artisanId}) {
    // TODO: implement getBookingsByDueDate
    throw UnimplementedError();
  }

  @override
  Future<BaseUser> getCustomerById({String id}) {
    // TODO: implement getCustomerById
    throw UnimplementedError();
  }

  @override
  Stream<List<BaseGallery>> getPhotosForArtisan({String userId}) {
    // TODO: implement getPhotosForArtisan
    throw UnimplementedError();
  }

  @override
  Stream<BaseArtisan> observeArtisanById({String id}) {
    // TODO: implement observeArtisanById
    throw UnimplementedError();
  }

  @override
  Stream<List<BaseArtisan>> observeArtisans({String category}) {
    // TODO: implement observeArtisans
    throw UnimplementedError();
  }

  @override
  Stream<List<BaseBooking>> observeBookingsForArtisan(String id) {
    // TODO: implement observeBookingsForArtisan
    throw UnimplementedError();
  }

  @override
  Stream<List<BaseBooking>> observeBookingsForCustomer(String id) {
    // TODO: implement observeBookingsForCustomer
    throw UnimplementedError();
  }

  @override
  Stream<List<BaseServiceCategory>> observeCategories(
      {ServiceCategoryGroup categoryGroup}) {
    // TODO: implement observeCategories
    throw UnimplementedError();
  }

  @override
  Stream<BaseServiceCategory> observeCategoryById({String id}) {
    // TODO: implement observeCategoryById
    throw UnimplementedError();
  }

  @override
  Stream<List<BaseConversation>> observeConversation(
      {String sender, String recipient}) {
    // TODO: implement observeConversation
    throw UnimplementedError();
  }

  @override
  Stream<BaseUser> observeCustomerById({String id}) {
    // TODO: implement observeCustomerById
    throw UnimplementedError();
  }

  @override
  Stream<List<BaseReview>> observeReviewsByCustomer(String id) {
    // TODO: implement observeReviewsByCustomer
    throw UnimplementedError();
  }

  @override
  Stream<List<BaseReview>> observeReviewsForArtisan(String id) {
    // TODO: implement observeReviewsForArtisan
    throw UnimplementedError();
  }

  @override
  Future<void> requestBooking(
      {String artisan,
      String customer,
      String category,
      String description,
      String image,
      double lat,
      double lng}) {
    // TODO: implement requestBooking
    throw UnimplementedError();
  }

  @override
  Future<List<BaseUser>> searchFor({String value, String categoryId}) {
    // TODO: implement searchFor
    throw UnimplementedError();
  }

  @override
  Future<void> sendMessage({BaseConversation conversation}) {
    // TODO: implement sendMessage
    throw UnimplementedError();
  }

  @override
  Future<void> sendReview({String message, String reviewer, String artisan}) {
    // TODO: implement sendReview
    throw UnimplementedError();
  }

  @override
  Future<void> updateBooking({BaseBooking booking}) {
    // TODO: implement updateBooking
    throw UnimplementedError();
  }

  @override
  Future<void> updateUser(BaseUser user) {
    // TODO: implement updateUser
    throw UnimplementedError();
  }

  @override
  Future<void> uploadBusinessPhotos({String userId, List<String> images}) {
    // TODO: implement uploadBusinessPhotos
    throw UnimplementedError();
  }
}
