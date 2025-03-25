import 'package:vector_math/vector_math_64.dart' as vector_math;

class ProductModel {
  String name;
  String imageUrl;
  int price;
  String manufacturer;
  String description;
  String color;
  int rating;
  String style;
  String madeIn;
  String ARurl;
  bool isFave = false;
  bool incart = false;
  int quantity;
  vector_math.Vector3? originalSize;
//  String category;

  ProductModel({
    required this.name,
    required this.quantity,
    required this.imageUrl,
    required this.price,
    required this.manufacturer,
    required this.description,
    required this.color,
    required this.rating,
    required this.style,
    required this.madeIn,
    required this.ARurl,
    this.isFave = false,
    this.incart = false,
    this.originalSize,
    //  required this.category
  });
}
