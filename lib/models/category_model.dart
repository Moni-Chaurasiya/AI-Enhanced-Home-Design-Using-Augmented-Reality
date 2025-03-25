import 'package:vector_math/vector_math_64.dart' as vector_math;

class CategoryModel {
  final String name;
  final String icon;
  final List<DetailModel> products;

  CategoryModel(
      {required this.name, required this.icon, required this.products});
}

class DetailModel {
  final String name;
  final String imageUrl;
  final String ARurl;
  vector_math.Vector3? originalSize;
  double price;
  int quantity;
  bool isInterior;

  DetailModel({
    required this.name,
    required this.imageUrl,
    required this.ARurl,
    this.originalSize,
    required this.price,
    required this.quantity,
    this.isInterior = false,
  });
}
