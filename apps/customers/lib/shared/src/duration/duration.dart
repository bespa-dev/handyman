import 'package:super_enum/super_enum.dart';

part 'duration.super.dart';

@superEnum
enum _SnackBarDuration {
  @object
  ShortLength,
  @object
  LongLength,
  @object
  InfiniteLength,
}

/// Durations
const kNoDuration = Duration(milliseconds: 150);
const kScaleDuration = Duration(milliseconds: 350);
const kTestDuration = Duration(milliseconds: 2500);
const kSheetDuration = Duration(milliseconds: 550);
const kSplashDuration = Duration(milliseconds: 2500);
const kDialogTransitionDuration = Duration(milliseconds: 150);
