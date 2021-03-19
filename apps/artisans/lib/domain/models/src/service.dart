abstract class BaseArtisanService {
  String id;
  String category;
  String name;
  double price;
  String artisanId;

  BaseArtisanService copyWith({
    String category,
    String name,
    double price,
    String artisanId,
  });

  Map<String, dynamic> toJson();

  @override
  String toString() => toJson().toString();
}
