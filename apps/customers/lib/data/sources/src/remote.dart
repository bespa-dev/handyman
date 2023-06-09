/*
 * Copyright (c) 2021.
 * This application is owned by HandyMan LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:lite/data/entities/entities.dart';
import 'package:lite/domain/models/models.dart';
import 'package:lite/domain/repositories/repositories.dart';
import 'package:lite/domain/sources/sources.dart';
import 'package:lite/shared/shared.dart';
import 'package:meta/meta.dart';

class FirebaseRemoteDatasource implements BaseRemoteDatasource {
  FirebaseRemoteDatasource(
      {@required this.prefsRepo, @required this.firestore}) {
    _performInitLoad();
  }

  final BasePreferenceRepository prefsRepo;
  final FirebaseFirestore firestore;

  void _performInitLoad() async {
    if (prefsRepo.isLoggedIn) return;

    /// decode categories from json
    var source = await rootBundle.loadString('assets/categories.json');
    var decoded = jsonDecode(source) as List;
    for (var json in decoded) {
      final item = ServiceCategory.fromJson(json);

      /// put each one into firestore document
      try {
        await firestore
            .collection(RefUtils.kCategoryRef)
            .doc(item.id)
            .set(item.toJson(), SetOptions(merge: true));
      } catch (e) {
        logger.e(e);
      }
    }
  }

  /// region reviews
  @override
  Future<void> deleteReviewById({@required String id}) async =>
      await firestore.collection(RefUtils.kReviewRef).doc(id).delete();

  @override
  Future<void> sendReview({@required BaseReview review}) async =>
      await firestore
          .collection(RefUtils.kReviewRef)
          .doc(review.id)
          .set(review.toJson(), SetOptions(merge: true));

  @override
  Stream<List<BaseReview>> observeReviewsByCustomer(String id) async* {
    yield* firestore
        .collection(RefUtils.kReviewRef)
        .where('customer_id', isLessThanOrEqualTo: id)
        .snapshots()
        .map((event) =>
            event.docs.map((e) => Review.fromJson(e.data())).toList());
  }

  @override
  Stream<List<BaseReview>> observeReviewsForArtisan(String id) async* {
    yield* firestore
        .collection(RefUtils.kReviewRef)
        .where('artisan_id', isLessThanOrEqualTo: id)
        .snapshots()
        .map((event) =>
            event.docs.map((e) => Review.fromJson(e.data())).toList());
  }

  /// endregion

  /// region users
  @override
  Future<BaseUser> getCustomerById({@required String id}) async {
    var snapshot =
        await firestore.collection(RefUtils.kCustomerRef).doc(id).get();
    return snapshot.exists ? Customer.fromJson(snapshot.data()) : null;
  }

  @override
  Stream<BaseUser> observeCustomerById({@required String id}) async* {
    yield* firestore
        .collection(RefUtils.kCustomerRef)
        .doc(id)
        .snapshots()
        .map((event) => Customer.fromJson(event.data()));
  }

  @override
  Future<void> updateUser(BaseUser user) async => await firestore
      .collection(RefUtils.kCustomerRef)
      .doc(user.id)
      .set(user.toJson(), SetOptions(merge: true));

  @override
  Stream<BaseUser> currentUser() async* {
    var snapshots = firestore
        .collection(RefUtils.kCustomerRef)
        .doc(prefsRepo.userId)
        .snapshots();
    yield* snapshots
        .map((event) => event.exists ? Customer.fromJson(event.data()) : null);
  }

  @override
  Future<BaseArtisan> getArtisanById({@required String id}) async {
    var snapshot =
        await firestore.collection(RefUtils.kArtisanRef).doc(id).get();
    return snapshot.exists ? Artisan.fromJson(snapshot.data()) : null;
  }

  @override
  Stream<BaseArtisan> observeArtisanById({@required String id}) async* {
    yield* firestore
        .collection(RefUtils.kArtisanRef)
        .doc(id)
        .snapshots()
        .map((event) => Artisan.fromJson(event.data()));
  }

  @override
  Stream<List<BaseArtisan>> observeArtisans(
      {@required String category}) async* {
    yield* firestore
        .collection(RefUtils.kArtisanRef)
        .where('category', isEqualTo: category)
        .where('id', isNotEqualTo: prefsRepo.userId)
        // disabling this will result in fetching snapshots when any changes
        // are made to the artisans collection. the check for approved will be
        // done locally
        // .where('approved', isEqualTo: true)
        .snapshots()
        .map((event) =>
            event.docs.map((e) => Artisan.fromJson(e.data())).toList());
  }

  /// endregion

  /// region businesses
  @override
  Future<List<BaseBusiness>> getBusinessesForArtisan(
      {@required String artisan}) async {
    var snapshot = await firestore
        .collection(RefUtils.kBusinessRef)
        .where('artisan_id', isEqualTo: artisan)
        .get();
    return snapshot.docs.map((e) => Business.fromJson(e.data())).toList();
  }

  @override
  Future<void> updateBusiness({@required BaseBusiness business}) async {
    await firestore
        .collection(RefUtils.kBusinessRef)
        .doc(business.id)
        .set(business.toJson(), SetOptions(merge: true));
  }

  @override
  Future<BaseBusiness> getBusinessById({@required String id}) async {
    var snapshot =
        await firestore.collection(RefUtils.kBusinessRef).doc(id).get();
    return snapshot.exists ? Business.fromJson(snapshot.data()) : null;
  }

  @override
  Stream<BaseBusiness> observeBusinessById({@required String id}) async* {
    yield* firestore.collection(RefUtils.kBusinessRef).doc(id).snapshots().map(
        (snapshot) =>
            snapshot.exists ? Business.fromJson(snapshot.data()) : null);
  }

  /// endregion

  /// region categories
  @override
  Stream<List<BaseServiceCategory>> observeCategories(
      {@required ServiceCategoryGroup categoryGroup}) async* {
    yield* firestore
        .collection(RefUtils.kCategoryRef)
        .where('group_name', isEqualTo: categoryGroup.name())
        .snapshots()
        .map((event) =>
            event.docs.map((e) => ServiceCategory.fromJson(e.data())).toList());
  }

  @override
  Stream<BaseServiceCategory> observeCategoryById(
      {@required String id}) async* {
    yield* firestore
        .collection(RefUtils.kCategoryRef)
        .doc(id)
        .snapshots()
        .map((event) => ServiceCategory.fromJson(event.data()));
  }

  /// endregion

  /// region services
  @override
  Future<List<BaseArtisanService>> getArtisanServices(
      {@required String id}) async {
    var snapshot = await firestore
        .collection('${RefUtils.kArtisanRef}/$id/${RefUtils.kServiceRef}')
        .get();
    return snapshot.size > 0
        ? snapshot.docs.map((e) => ArtisanService.fromJson(e.data())).toList()
        : [];
  }

  @override
  Future<void> updateArtisanService(
      {@required String id,
      @required BaseArtisanService artisanService}) async {
    var doc = firestore
        .collection('${RefUtils.kArtisanRef}/$id/${RefUtils.kServiceRef}')
        .doc(artisanService.id);
    await (artisanService.artisanId == null
        ? doc.delete()
        : doc.set(artisanService.toJson(), SetOptions(merge: true)));
  }

  @override
  Future<BaseArtisanService> getArtisanServiceById(
      {@required String id}) async {
    var snapshot =
        await firestore.collection(RefUtils.kServiceRef).doc(id).get();

    return snapshot.exists ? ArtisanService.fromJson(snapshot.data()) : null;
  }

  /// endregion

  /// region conversations
  @override
  Stream<List<BaseConversation>> observeConversation(
      {@required String sender, @required String recipient}) async* {
    yield* firestore
        .collection(RefUtils.kConversationRef)
        .snapshots()
        .map((element) => element.docs
            .map((e) => Conversation.fromJson(e.data()))
            .where((item) =>
                (item.author == sender || item.author == recipient) &&
                (item.recipient == sender || item.recipient == recipient))
            .sortByDescending<String>((r) => r.createdAt)
            .toList())
        .asBroadcastStream();
  }

  @override
  Future<void> sendMessage({@required BaseConversation conversation}) async =>
      await firestore
          .collection(RefUtils.kConversationRef)
          .doc(conversation.id)
          .set(conversation.toJson(), SetOptions(merge: true));

  /// endregion

  /// region galleries
  @override
  Stream<List<BaseGallery>> getPhotosForArtisan(
      {@required String userId}) async* {
    yield* firestore
        .collection(RefUtils.kGalleryRef)
        .where('user_id', isEqualTo: userId)
        .snapshots()
        .map((event) =>
            event.docs.map((e) => Gallery.fromJson(e.data())).toList());
  }

  @override
  Future<void> uploadBusinessPhotos(
      {@required List<BaseGallery> galleryItems}) async {
    for (var item in galleryItems) {
      await firestore
          .collection(RefUtils.kGalleryRef)
          .doc(item.id)
          .set(item.toJson(), SetOptions(merge: true));
    }
  }

  /// endregion

  /// region bookings
  @override
  Stream<List<BaseBooking>> bookingsForCustomerAndArtisan(
      String customerId, String artisanId) async* {
    yield* firestore
        .collection(RefUtils.kBookingRef)
        .where('customer_id', isEqualTo: customerId)
        .where('artisan_id', isEqualTo: artisanId)
        .snapshots()
        .map((event) =>
            event.docs.map((e) => Booking.fromJson(e.data())).toList());
  }

  @override
  Future<void> deleteBooking({@required BaseBooking booking}) async =>
      await firestore
          .collection(RefUtils.kBookingRef)
          .doc(booking.id)
          .set(booking.toJson(), SetOptions(merge: true));

  @override
  Stream<BaseBooking> getBookingById({@required String id}) async* {
    yield* firestore
        .collection(RefUtils.kBookingRef)
        .doc(id)
        .snapshots()
        .map((event) => event.exists ? Booking.fromJson(event.data()) : null);
  }

  @override
  Stream<List<BaseBooking>> getBookingsByDueDate(
      {@required String dueDate, @required String artisanId}) async* {
    yield* firestore
        .collection(RefUtils.kBookingRef)
        .where('due_date', isLessThanOrEqualTo: dueDate)
        .where('artisan_id', isEqualTo: artisanId)
        .snapshots()
        .map((event) =>
            event.docs.map((e) => Booking.fromJson(e.data())).toList());
  }

  @override
  Stream<List<BaseBooking>> observeBookingsForArtisan(String id) async* {
    yield* firestore
        .collection(RefUtils.kBookingRef)
        .where('artisan_id', isEqualTo: id)
        .snapshots()
        .map((event) =>
            event.docs.map((e) => Booking.fromJson(e.data())).toList());
  }

  @override
  Stream<List<BaseBooking>> observeBookingsForCustomer(String id) async* {
    yield* firestore
        .collection(RefUtils.kBookingRef)
        .where('customer_id', isEqualTo: id)
        .snapshots()
        .map((event) =>
            event.docs.map((e) => Booking.fromJson(e.data())).toList());
  }

  @override
  Future<void> requestBooking({@required BaseBooking booking}) async =>
      await firestore
          .collection(RefUtils.kBookingRef)
          .doc(booking.id)
          .set(booking.toJson(), SetOptions(merge: true));

  @override
  Future<void> updateBooking({@required BaseBooking booking}) async =>
      await firestore
          .collection(RefUtils.kBookingRef)
          .doc(booking.id)
          .set(booking.toJson(), SetOptions(merge: true));

  /// endregion
}
