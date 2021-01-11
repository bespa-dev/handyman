import 'package:super_enum/super_enum.dart';

part 'search_event.super.dart';

@superEnum
enum _SearchEvent {
  @Data(fields: [DataField<String>("query")])
  SearchAllUsers,
}
