/*
 * Copyright (c) 2021.
 * This application is owned by HandyMan LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */

import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:lite/domain/models/models.dart';

part 'conversation.g.dart';

@HiveType(typeId: 2)
@JsonSerializable(fieldRename: FieldRename.snake)
class Conversation extends BaseConversation {
  @HiveField(0)
  @override
  final String author;

  @HiveField(1)
  @override
  final String recipient;

  @HiveField(2)
  @override
  final String body;

  @HiveField(3)
  @override
  final String format;

  @HiveField(4)
  @override
  final String id;

  @HiveField(5)
  @override
  final String createdAt;

  Conversation({
    this.createdAt,
    this.id,
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
