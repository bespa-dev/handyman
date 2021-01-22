/*
 * Copyright (c) 2021.
 * This application is owned by HandyMan LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */
import 'package:super_enum/super_enum.dart';

part 'conversation_event.super.dart';

@superEnum
enum _ConversationEvent {
  @generic
  @Data(fields: [
    DataField<String>('sender'),
    DataField<String>('recipient'),
    DataField<String>('message'),
    DataField<Generic>('type'),
  ])
  SendMessage,
  @Data(fields: [
    DataField<String>('sender'),
    DataField<String>('recipient'),
  ])
  GetMessages,
}
