import 'package:handyman/domain/models/models.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'business.g.dart';

@HiveType(typeId: 7)
@JsonSerializable(fieldRename: FieldRename.snake)
class Business extends BaseBusiness {
  Business({
    @required this.id,
    @required this.createdAt,
    @required this.docUrl,
    @required this.artisanId,
    @required this.name,
    @required this.location,
  });

  factory Business.fromJson(Map<String, dynamic> json) =>
      _$BusinessFromJson(json);

  @HiveField(0)
  @override
  final String id;

  @HiveField(1)
  @override
  final String createdAt;

  @HiveField(2)
  @override
  final String docUrl;

  @HiveField(3)
  @override
  final String artisanId;

  @HiveField(4)
  @override
  final String name;

  @HiveField(5)
  @override
  final String location;

  @override
  Map<String, dynamic> toJson() => _$BusinessToJson(this);

  @override
  dynamic get model => this;

  @override
  BaseBusiness copyWith({
    String docUrl,
    String artisanId,
    String name,
    String location,
  }) =>
      Business(
        id: id,
        createdAt: createdAt,
        docUrl: docUrl ?? this.docUrl,
        artisanId: artisanId ?? this.artisanId,
        name: name ?? this.name,
        location: location ?? this.location,
      );
}
