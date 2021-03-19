import 'package:handyman/domain/models/models.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'service.g.dart';

@JsonSerializable(
    fieldRename: FieldRename.snake, genericArgumentFactories: true)
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

  ArtisanService({
    @required this.id,
    @required this.category,
    @required this.name,
    @required this.price,
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
}
