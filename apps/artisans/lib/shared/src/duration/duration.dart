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
const kScaleDuration = const Duration(milliseconds: 350);
const kTestDuration = const Duration(milliseconds: 2500);
const kSheetDuration = const Duration(milliseconds: 550);
const kSplashDuration = const Duration(milliseconds: 1550);
