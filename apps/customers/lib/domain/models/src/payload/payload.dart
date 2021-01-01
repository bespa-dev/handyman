/*
 * Copyright (c) 2021.
 * This application is owned by HandyMan LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */

import 'package:super_enum/super_enum.dart';

part 'payload.super.dart';

/// payload type for notification grouping
@superEnum
enum _PayloadType {
  @object
  ConversationPayload, // conversations
  @object
  BookingPayload, // bookings
}
