import 'package:lite/domain/models/models.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'service.g.dart';

@JsonSerializable()
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

  ArtisanService({
    @required this.id,
    @required this.category,
    @required this.name,
    @required this.price,
  });

  @override
  BaseArtisanService copyWith({
    String category,
    String name,
    double price,
  }) =>
      ArtisanService(
        id: this.id,
        name: name ??= this.name,
        category: category ??= this.category,
        price: price ??= this.price,
      );

  factory ArtisanService.fromJson(Map<String, dynamic> json) =>
      _$ArtisanServiceFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ArtisanServiceToJson(this);
}
