abstract class BaseServiceIssue {
  String name;
  double price;

  BaseServiceIssue copyWith({double price});

  Map<String, dynamic> toJson();

  @override
  String toString() => toJson().toString();
}

abstract class BaseArtisanService {
  String id;
  String category;
  String name;
  double price;
  String artisanId;
  List<BaseServiceIssue> issues;

  bool get hasIssues;

  BaseArtisanService copyWith({
    String category,
    String name,
    double price,
    String artisanId,
    List<BaseServiceIssue> issues,
  });

  Map<String, dynamic> toJson();

  @override
  String toString() => toJson().toString();
}
