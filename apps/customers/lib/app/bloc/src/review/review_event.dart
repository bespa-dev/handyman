import 'package:super_enum/super_enum.dart';

part 'review_event.super.dart';


@superEnum
enum _ReviewEvent {
  @Data(fields: [DataField<String>("id")])
  DeleteReview,
  @Data(fields: [DataField<String>("id")])
  ObserveReviewsForArtisan,
  @Data(fields: [DataField<String>("id")])
  ObserveReviewsByCustomer,
  @Data(fields: [
    DataField<String>("message"),
    DataField<String>("reviewer"),
    DataField<String>("artisan"),
    DataField<double>("rating"),
  ])
  SendReview,
}
