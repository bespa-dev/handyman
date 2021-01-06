/*
 * Copyright (c) 2021.
 * This application is owned by HandyMan LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:handyman/data/entities/entities.dart';
import 'package:handyman/domain/models/models.dart';
import 'package:handyman/domain/repositories/repositories.dart';
import 'package:handyman/domain/sources/sources.dart';
import 'package:handyman/shared/shared.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:meta/meta.dart';

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
    ..registerAdapter(CustomerAdapter())
    ..registerAdapter(BusinessAdapter());

  /// open boxes
  await Hive.openBox<Booking>(RefUtils.kBookingRef);
  await Hive.openBox<ServiceCategory>(RefUtils.kCategoryRef);
  await Hive.openBox<Conversation>(RefUtils.kConversationRef);
  await Hive.openBox<Gallery>(RefUtils.kGalleryRef);
  await Hive.openBox<Review>(RefUtils.kReviewRef);
  await Hive.openBox<Artisan>(RefUtils.kArtisanRef);
  await Hive.openBox<Customer>(RefUtils.kCustomerRef);
  await Hive.openBox<Business>(RefUtils.kBusinessRef);
}

class HiveLocalDatasource extends BaseLocalDatasource {
  final BasePreferenceRepository prefsRepo;
  final Box<Booking> bookingBox;
  final Box<Customer> customerBox;
  final Box<Artisan> artisanBox;
  final Box<Review> reviewBox;
  final Box<Gallery> galleryBox;
  final Box<Conversation> conversationBox;
  final Box<ServiceCategory> categoryBox;
  final Box<Business> businessBox;

  HiveLocalDatasource({
    @required this.prefsRepo,
    @required this.bookingBox,
    @required this.customerBox,
    @required this.artisanBox,
    @required this.reviewBox,
    @required this.galleryBox,
    @required this.conversationBox,
    @required this.categoryBox,
    @required this.businessBox,
  }) {
    /// load initial data from assets
    _performInitLoad();
  }

  void _performInitLoad() async {
    /// decode categories from json
    var source = await rootBundle.loadString("assets/categories.json");
    var decoded = jsonDecode(source) as List;
    for (var json in decoded) {
      final item = ServiceCategory.fromJson(json);

      /// put each one into box
      await categoryBox.put(item.id, item);
    }
  }

  @override
  Stream<List<BaseBooking>> bookingsForCustomerAndArtisan(
      String customerId, String artisanId) async* {
    yield bookingBox.values
        .where((item) => item.artisanId == artisanId)
        .where((item) => item.customerId == customerId)
        .toList();
    notifyListeners();
  }

  @override
  Stream<BaseUser> currentUser() async* {
    if (!prefsRepo.isLoggedIn) return;
    var customer = artisanBox.get(prefsRepo.userId);
    yield customer;
    notifyListeners();
  }

  @override
  Future<void> deleteBooking({BaseBooking booking}) async {
    await bookingBox.delete(booking.id);
    notifyListeners();
  }

  @override
  Future<void> deleteReviewById({String id}) async {
    await reviewBox.delete(id);
    notifyListeners();
  }

  @override
  Future<BaseArtisan> getArtisanById({String id}) async => artisanBox.get(id);

  @override
  Stream<BaseBooking> getBookingById({String id}) async* {
    yield bookingBox.get(id);
  }

  @override
  Stream<List<BaseBooking>> getBookingsByDueDate(
      {String dueDate, String artisanId}) async* {
    yield bookingBox.values
        .where((item) => compareTime(item.dueDate, dueDate) <= 0)
        .where((item) => item.artisanId == artisanId)
        .toList();
  }

  @override
  Future<BaseUser> getCustomerById({String id}) async => customerBox.get(id);

  @override
  Stream<List<BaseGallery>> getPhotosForArtisan({String userId}) async* {
    yield galleryBox.values.where((item) => item.userId == userId).toList();
  }

  @override
  Stream<BaseArtisan> observeArtisanById({String id}) async* {
    yield artisanBox.get(id);
  }

  @override
  Stream<List<BaseArtisan>> observeArtisans({String category}) async* {
    yield artisanBox.values
        .where((item) => item.categoryGroup.contains(category))
        .where((item) => item.id != prefsRepo.userId)
        .toList();
  }

  @override
  Stream<List<BaseBooking>> observeBookingsForArtisan(String id) async* {
    yield bookingBox.values.where((item) => item.artisanId == id).toList();
  }

  @override
  Stream<List<BaseBooking>> observeBookingsForCustomer(String id) async* {
    yield bookingBox.values.where((item) => item.customerId == id).toList();
  }

  @override
  Stream<List<BaseServiceCategory>> observeCategories(
      {ServiceCategoryGroup categoryGroup}) async* {
    yield categoryBox.values
        .where((item) => item.groupName.contains(categoryGroup.name()))
        .toList();
  }

  @override
  Stream<BaseServiceCategory> observeCategoryById({String id}) async* {
    yield categoryBox.get(id);
  }

  @override
  Stream<List<BaseConversation>> observeConversation(
      {String sender, String recipient}) async* {
    yield conversationBox.values
        .where((item) => item.author == sender || item.recipient == sender)
        .where(
            (item) => item.author == recipient || item.recipient == recipient)
        .toList();
  }

  @override
  Stream<BaseUser> observeCustomerById({String id}) async* {
    yield customerBox.get(id);
  }

  @override
  Stream<List<BaseReview>> observeReviewsByCustomer(String id) async* {
    yield reviewBox.values.where((item) => item.customerId == id).toList();
  }

  @override
  Stream<List<BaseReview>> observeReviewsForArtisan(String id) async* {
    yield reviewBox.values.where((item) => item.artisanId == id).toList();
  }

  @override
  Future<void> requestBooking({@required BaseBooking booking}) async {
    await bookingBox.put(booking.id, booking);
    notifyListeners();
  }

  @override
  Future<List<BaseUser>> searchFor({String query, String categoryId}) async {
    return artisanBox.values
        .where((item) =>
            item.email.contains(query) ||
            item.category.contains(query) ||
            item.phone.contains(query) ||
            item.name.contains(query))
        .toList();
  }

  @override
  Future<void> sendMessage({@required BaseConversation conversation}) async =>
      await conversationBox.put(conversation.id, conversation);

  @override
  Future<void> sendReview({@required BaseReview review}) async =>
      await reviewBox.put(review.id, review);

  @override
  Future<void> updateBooking({@required BaseBooking booking}) async =>
      await bookingBox.put(booking.id, booking);

  @override
  Future<void> updateCategory({BaseServiceCategory category}) async =>
      await categoryBox.put(category.id, category);

  @override
  Future<void> updateGallery({BaseGallery gallery}) async =>
      await galleryBox.put(gallery.id, gallery);

  @override
  Future<void> updateReview({BaseReview review}) async =>
      await reviewBox.put(review.id, review);

  @override
  Future<void> updateUser(BaseUser user) async {
    await artisanBox.put(user.id, user);
    notifyListeners();
  }

  @override
  Future<void> uploadBusinessPhotos(
      {@required List<BaseGallery> galleryItems}) async {
    for (var value in galleryItems) {
      await galleryBox.put(value.id, value);
    }
  }

  @override
  Future<List<BaseBusiness>> getBusinessesForArtisan(
          {@required String artisan}) async =>
      businessBox.values.where((item) => item.artisanId == artisan).toList();

  @override
  Future<void> updateBusiness({@required BaseBusiness business}) async =>
      await businessBox.put(business.id, business);
}
