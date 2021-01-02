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
import 'package:lite/domain/models/models.dart';
import 'package:lite/domain/repositories/repositories.dart';
import 'package:lite/domain/sources/sources.dart';
import 'package:lite/shared/shared.dart';
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

class HiveLocalDatasource extends BaseLocalDatasource {
  final BasePreferenceRepository prefsRepo;
  final Box<Booking> bookingBox;
  final Box<Customer> customerBox;
  final Box<Artisan> artisanBox;
  final Box<Review> reviewBox;
  final Box<Gallery> galleryBox;
  final Box<Conversation> conversationBox;
  final Box<ServiceCategory> categoryBox;

  HiveLocalDatasource({
    @required this.prefsRepo,
    @required this.bookingBox,
    @required this.customerBox,
    @required this.artisanBox,
    @required this.reviewBox,
    @required this.galleryBox,
    @required this.conversationBox,
    @required this.categoryBox,
  });

  @override
  Stream<List<BaseBooking>> bookingsForCustomerAndArtisan(
      String customerId, String artisanId) async* {
    // TODO:
  }

  @override
  Stream<BaseUser> currentUser() async* {
    if (!prefsRepo.isLoggedIn) return;
    var customer = customerBox.get(prefsRepo.userId);
    yield customer;
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
  Future<BaseArtisan> getArtisanById({String id}) async => artisanBox.get(id);

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
  Future<BaseUser> getCustomerById({String id}) async => customerBox.get(id);

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
  Future<List<BaseUser>> searchFor({String query, String categoryId}) {
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
  Future<void> updateCategory({BaseServiceCategory category}) {
    // TODO: implement updateCategory
    throw UnimplementedError();
  }

  @override
  Future<void> updateGallery({BaseGallery gallery}) {
    // TODO: implement updateGallery
    throw UnimplementedError();
  }

  @override
  Future<void> updateReview({BaseReview review}) {
    // TODO: implement updateReview
    throw UnimplementedError();
  }

  @override
  Future<void> updateUser(BaseUser user) async {
    if (user is Customer) {
      await customerBox.put(user.id, user);
    } else if (user is Artisan) {
      await artisanBox.put(user.id, user);
    }
  }

  @override
  Future<void> uploadBusinessPhotos({String userId, List<String> images}) {
    // TODO: implement uploadBusinessPhotos
    throw UnimplementedError();
  }
}
