// import 'package:flutter/material.dart';
// import '../../../constants/constants.dart';

// class ProductsPlaceholder extends StatelessWidget {
//   final String category;

//   const ProductsPlaceholder({Key? key, required this.category})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.black12, // Light grey background
//       child: Center(
//         child: Text(
//           '$category Products Coming Soon!',
//           style: TextStyle(
//             color: Colors.black54,
//             fontSize: 20,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class ProductsPlaceholder extends StatelessWidget {
  final String category;

  const ProductsPlaceholder({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'No products available for $category yet.',
        style: const TextStyle(fontSize: 18.0, color: Colors.grey),
      ),
    );
  }
}
