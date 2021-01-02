/*
 * Copyright (c) 2021.
 * This application is owned by HandyMan LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */

import 'package:json_annotation/json_annotation.dart';
import 'package:lite/domain/models/models.dart';

part 'conversation.g.dart';

@JsonSerializable()
class Conversation extends BaseConversation {
  final String author;
  final String recipient;
  final String body;
  final String format;

  Conversation({
    this.author,
    this.recipient,
    this.body,
    this.format,
  });

  @override
  get model => this;

  @override
  Map<String, dynamic> toJson() => _$ConversationToJson(this);

  factory Conversation.fromJson(Map<String, dynamic> json) =>
      _$ConversationFromJson(json);
}
