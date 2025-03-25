// In product_scroll_bar.dart
import 'package:flutter/material.dart';
//import '../models/category_model.dart';
//import '../controllers/ar_controller.dart';
import '../ArController.dart';
import 'package:vector_math/vector_math_64.dart' as vector_math;
import '../constants/fetch.dart';

class ProductScrollBar extends StatefulWidget {
  final List<Item> items;

  final Function(String, vector_math.Vector3?, double)
      onProductSelected; // Modified Function signature

  ProductScrollBar({
    Key? key,
    required this.items,
    required this.onProductSelected,
  }) : super(key: key);

  @override
  State<ProductScrollBar> createState() => _ProductScrollBarState();
}

class _ProductScrollBarState extends State<ProductScrollBar> {
  int? _selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      color: Colors.black.withOpacity(0.5),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.items.length,
        itemBuilder: (context, index) {
          final item = widget.items[index];

          // Handle null arUrl by providing a default value or showing an error message
          String arUrl = item.arUrl ?? ''; // Use empty string as a fallback

          return GestureDetector(
            onTap: () {
              print("Selected product: ${item.name}");

              setState(() {
                _selectedIndex = index; // Update selected index
              });

              if (arUrl.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("AR model unavailable for ${item.name}"),
                    duration: Duration(seconds: 2),
                  ),
                );
              } else {
                ARController.instance.placeObject(arUrl); // Pass the AR URL
                widget.onProductSelected(arUrl, item.originalSize, item.price);
              }
            },
            child: Container(
              margin: const EdgeInsets.all(0),
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: _selectedIndex == index
                          ? Border.all(color: Colors.blue, width: 2)
                          : null,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.network(
                            item.imgurl, // Use the fetched image URL
                            width: 70,
                            height: 70,
                          ),
                        ),
                      ],
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
