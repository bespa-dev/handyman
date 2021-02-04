import 'package:super_enum/super_enum.dart';

part 'booking_event.super.dart';

@superEnum
enum _BookingEvent {
  @Data(fields: [DataField<String>('id')])
  ObserveBookingById,
  @Data(fields: [DataField<String>('id')])
  ObserveBookingForArtisan,
  @Data(fields: [DataField<String>('id')])
  ObserveBookingForCustomer,
  @generic
  @Data(fields: [
    DataField<String>('artisan'),
    DataField<String>('customer'),
    DataField<String>('category'),
    DataField<String>('description'),
    DataField<String>('serviceType'),
    DataField<String>('image'),
    DataField<double>('cost'),
    DataField<Generic>('location'),
  ])
  RequestBooking,
  @Data(fields: [DataField<String>('dueDate'), DataField<String>('artisan')])
  GetBookingByDueDate,
  @Data(fields: [DataField<String>('customer'), DataField<String>('artisan')])
  GetBookingsForCustomerAndArtisan,
  @generic
  @Data(fields: [DataField<Generic>('booking')])
  DeleteBooking,
  @generic
  @Data(fields: [DataField<Generic>('booking')])
  UpdateBooking,
}
