/*
 * Copyright (c) 2021.
 * This application is owned by HandyMan LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */

import 'package:handyman/domain/models/models.dart' show BaseModel;
import 'package:super_enum/super_enum.dart';

part 'conversation.super.dart';

@superEnum
enum _ConversationFormat {
  @object
  TextFormat,
  @object
  ImageFormat,
}

abstract class BaseConversation extends BaseModel {
  String author;
  String recipient;
  String body;
  String format; // one of ConversationFormat
}

extension ConversationFormatX on ConversationFormat {
  String name() => this.toString().replaceAll("()", "").toLowerCase();

  ConversationFormat fromName(String name) =>
      name.contains(this.toString()) ? this : ConversationFormat.textFormat();
}
