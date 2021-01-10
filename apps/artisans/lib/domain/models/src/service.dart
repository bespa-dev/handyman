abstract class BaseArtisanService {
  String id;
  String category;
  String name;
  double price;

  BaseArtisanService copyWith({
    String category,
    String name,
    double price,
  });

  Map<String, dynamic> toJson();

  @override
  String toString() => toJson().toString();
}
