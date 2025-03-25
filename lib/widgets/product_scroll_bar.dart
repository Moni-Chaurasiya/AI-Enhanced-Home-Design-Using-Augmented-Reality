/*
// In product_scroll_bar.dart
import 'package:flutter/material.dart';
import '../models/category_model.dart';
//import '../controllers/ar_controller.dart';
import '../ArController.dart';
import 'package:vector_math/vector_math_64.dart' as vector_math;

// In product_scroll_bar.dart
class ProductScrollBar extends StatelessWidget {
  final List<DetailModel> products;
  final Function(String, vector_math.Vector3?, double)
      onProductSelected; // Modified Function signature

  const ProductScrollBar({
    Key? key,
    required this.products,
    required this.onProductSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      color: Colors.black.withOpacity(0.5),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return GestureDetector(
            onTap: () {
              print("Selected product: ${product.name}");
              ARController.instance.placeObject(product
                  .ARurl); // We still need to set the ARUrl in ARController
              onProductSelected(product.ARurl, product.originalSize,
                  product.price); // Pass originalSize here
            },
            child: Container(
              margin: const EdgeInsets.all(0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      product.imageUrl,
                      width: 70,
                      height: 70,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
*/

import 'package:flutter/material.dart';
import '../models/category_model.dart';
//import '../controllers/ar_controller.dart';
import '../ArController.dart';
import 'package:vector_math/vector_math_64.dart' as vector_math;

class ProductScrollBar extends StatelessWidget {
  final List<DetailModel> products;
  final Function(String, vector_math.Vector3?, double, bool)
      onProductSelected; // Modified Function signature

  const ProductScrollBar({
    Key? key,
    required this.products,
    required this.onProductSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      color: Colors.black.withOpacity(0.5),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return GestureDetector(
            onTap: () {
              print("Selected product: ${product.name}");
              ARController.instance.placeObject(product
                  .ARurl); // We still need to set the ARUrl in ARController
              onProductSelected(
                  product.ARurl,
                  product.originalSize,
                  product.price,
                  product.isInterior); // Pass originalSize and isInterior here
            },
            child: Container(
              margin: const EdgeInsets.all(0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network(
                      product.imageUrl,
                      width: 70,
                      height: 70,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
