import 'package:flutter/material.dart';

import 'curve_clipper.dart';

class ProductImage extends StatelessWidget {
  const ProductImage({Key? key, required this.imageUrl}) : super(key: key);

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return ClipPath(
      clipper: CurveClipper(),
      child: Align(
        alignment: Alignment.topCenter,
        child: Center(
          child: Image.network(
            imageUrl,
            height: size.height * 0.3,
            width: size.width,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
