import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';

String parseFromTimestamp(
  String time, {
  bool isChatFormat = false,
  bool isDetailedFormat = false,
  bool fromNow = false,
}) {
  final timestamp = DateTime.parse(time);
  return fromNow
      ? Jiffy.unix(timestamp.millisecondsSinceEpoch).fromNow()
      : isChatFormat
          ? Jiffy.unix(timestamp.millisecondsSinceEpoch).Hm
          : isDetailedFormat
              ? Jiffy.unix(timestamp.millisecondsSinceEpoch).yMMMEd
              : Jiffy.unix(timestamp.millisecondsSinceEpoch).yMMMd;
}

int compareTime(String first, String second) =>
    DateTime.tryParse(first).compareTo(DateTime.tryParse(second));

String countDownFrom(String first) =>
    Jiffy.unix(DateTime.tryParse(first).millisecondsSinceEpoch).fromNow();

String formatCurrency(double amount) {
  var cediFormat = NumberFormat.currency(
      decimalDigits: 2, locale: "en_GH", symbol: "\u00a2");
  return cediFormat.format(amount);
}
