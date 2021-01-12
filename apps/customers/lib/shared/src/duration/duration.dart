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
const kNoDuration = const Duration(milliseconds: 150);
const kScaleDuration = const Duration(milliseconds: 350);
const kTestDuration = const Duration(milliseconds: 2500);
const kSheetDuration = const Duration(milliseconds: 550);
const kSplashDuration = const Duration(milliseconds: 3500);
const kDialogTransitionDuration = const Duration(milliseconds: 150);
