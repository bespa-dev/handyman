import 'package:super_enum/super_enum.dart';

part 'duration.super.dart';

@superEnum
enum _SnackBarDuration {
  @object
  shortLength,
  @object
  longLength,
  @object
  infiniteLength,
}

/// Durations
const kNoDuration = Duration(milliseconds: 225);
const kScaleDuration = Duration(milliseconds: 350);
const kTestDuration = Duration(milliseconds: 2500);
const kSheetDuration = Duration(milliseconds: 550);
const kSplashDuration = Duration(milliseconds: 1500);
const kDialogTransitionDuration = Duration(milliseconds: 150);
