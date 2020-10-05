import 'package:handyman/data/entities/category.dart';
import 'package:handyman/data/local_database.dart';
import 'package:handyman/domain/models/user.dart';
import 'package:meta/meta.dart';

/// Base data service
abstract class DataService {
  Stream<List<BaseUser>> getArtisans({@required String category});

  Stream<BaseUser> getArtisanById({@required String id});

  Stream<BaseUser> getCustomerById({@required String id});

  Stream<List<ServiceCategory>> getCategories(
      {CategoryGroup categoryGroup = CategoryGroup.FEATURED});

  Stream<ServiceCategory> getCategoryById({String id});

  Stream<List<CustomerReview>> getReviewsForProvider(String id);

  Future<void> sendReview({String message, String reviewer, artisan});

  Stream<List<Booking>> getBookingsForProvider(String id);

  Stream<List<Booking>> getBookingsForCustomer(String id);

  Stream<List<Booking>> bookingsForCustomerAndProvider(
      String customerId, String providerId);

  Stream<List<Gallery>> getPhotosForUser(String userId);

  Future<List<BaseUser>> searchFor({@required String value, String categoryId});

  Stream<List<Conversation>> getConversation(
      {@required String sender, @required String recipient});

  Future<void> sendMessage({@required Conversation conversation});

  Future<void> updateUser(BaseUser user, {bool sync = true});

  Stream<Booking> getBookingById({String id});

  Stream<List<Booking>> getBookingsByDueDate(
      {String dueDate, String providerId});
}
