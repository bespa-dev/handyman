import 'package:handyman/domain/models/models.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'service.g.dart';

class BaseServiceIssueSerializer
    implements JsonConverter<BaseServiceIssue, Map<String, dynamic>> {
  const BaseServiceIssueSerializer();

  @override
  BaseServiceIssue fromJson(Map<String, dynamic> json) =>
      ServiceIssue.fromJson(json);

  @override
  Map<String, dynamic> toJson(BaseServiceIssue instance) => instance.toJson();
}

@JsonSerializable(fieldRename: FieldRename.snake)
class ServiceIssue extends BaseServiceIssue {
  ServiceIssue({this.name, this.price});

  factory ServiceIssue.fromJson(Map<String, dynamic> json) =>
      _$ServiceIssueFromJson(json);

  @override
  final String name;

  @override
  final double price;

  @override
  BaseServiceIssue copyWith({double price}) =>
      ServiceIssue(name: name, price: price ??= this.price);

  @override
  Map<String, dynamic> toJson() => _$ServiceIssueToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
@HiveType(typeId: 9)
class ArtisanService extends BaseArtisanService {
  @override
  @HiveField(0)
  final String id;

  @override
  @HiveField(1)
  final String category;

  @override
  @HiveField(2)
  final double price;

  @override
  @HiveField(3)
  final String name;

  @override
  @HiveField(4)
  final String artisanId;

  @override
  @HiveField(5)
  @BaseServiceIssueSerializer()
  final List<BaseServiceIssue> issues;

  ArtisanService({
    @required this.id,
    @required this.category,
    @required this.name,
    @required this.price,
    this.issues = const <BaseServiceIssue>[],
    this.artisanId,
  });

  @override
  BaseArtisanService copyWith({
    String category,
    String name,
    double price,
    String artisanId,
  }) =>
      ArtisanService(
        id: id,
        name: name ??= this.name,
        category: category ??= this.category,
        price: price ??= this.price,
        artisanId: artisanId ??= this.artisanId,
      );

  factory ArtisanService.fromJson(Map<String, dynamic> json) =>
      _$ArtisanServiceFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ArtisanServiceToJson(this);

  @override
  bool get hasIssues => issues != null && issues.isNotEmpty;
}
