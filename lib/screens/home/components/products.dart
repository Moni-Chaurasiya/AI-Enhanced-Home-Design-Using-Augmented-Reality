/*
import 'package:flutter/material.dart';
import '../../../constants/constants.dart';
import '../../../data/data.dart';
import '../../../models/product_model.dart';
import '../../details/details_screen.dart';

class Products extends StatelessWidget {
  const Products({Key? key}) : super(key: key);

  Widget _buildProductCard(BuildContext context, int index) {
    Size size = MediaQuery.of(context).size;
    ProductModel product =
        productList[index]; // Ensure productList corresponds to 'Furniture'

    return GestureDetector(
      // onTap: () {
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //       builder: (_) => DetailsScreen(
      //         product: product,
      //       ),
      //     ),
      //   );
      // },
      onTap: () {
        showProductPopup(context, product);
      },
      child: Padding(
        padding: const EdgeInsets.all(appPadding / 3),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                product.imageUrl,
                fit: BoxFit.cover,
                height: size.height * 0.24,
                width: size.width * 0.45,
              ),
            ),
            const SizedBox(height: 8), // Spacing between image and text
            // Product Name
            Text(
              product.name,
              style: const TextStyle(
                overflow: TextOverflow.ellipsis,
                color: black,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      // Removed Expanded
      padding: const EdgeInsets.symmetric(horizontal: appPadding),
      child: GridView.builder(
        padding: const EdgeInsets.only(bottom: appPadding * 2),
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Number of columns
          childAspectRatio: 0.65, // Adjust as needed
        ),
        itemCount: productList.length,
        itemBuilder: (context, index) {
          return Transform.translate(
            offset: Offset(0.0, index.isOdd ? 30 : 0.0),
            child: _buildProductCard(context, index),
          );
        },
      ),
    );
  }
}
*/

import 'package:flutter/material.dart';
import '../../../constants/constants.dart';
import '../../../models/product_model.dart';
import '../../../data/fetch.dart';
import '../../details/details_screen.dart';

class Products extends StatefulWidget {
  const Products({Key? key}) : super(key: key);

  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  late Future<List<ProductModel>> futureProducts;

  @override
  void initState() {
    super.initState();
    futureProducts = fetchProducts(); // Fetch data when widget initializes
  }

  Widget _buildProductCard(BuildContext context, ProductModel product) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        showProductPopup(context, product);
      },
      child: Padding(
        padding: const EdgeInsets.all(appPadding / 3),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                product
                    .imageUrl, // Changed from `Image.asset` to `Image.network`
                fit: BoxFit.cover,
                height: size.height * 0.24,
                width: size.width * 0.45,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.error), // Handle errors
              ),
            ),
            const SizedBox(height: 8),
            Text(
              product.name,
              style: const TextStyle(
                overflow: TextOverflow.ellipsis,
                color: black,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: appPadding),
      child: FutureBuilder<List<ProductModel>>(
        future: futureProducts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator()); // Show loading indicator
          } else if (snapshot.hasError) {
            return Center(
                child: Text('Error: ${snapshot.error}')); // Show error message
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No products available.'));
          }

          List<ProductModel> productList = snapshot.data!;

          return GridView.builder(
            padding: const EdgeInsets.only(bottom: appPadding * 2),
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.65,
            ),
            itemCount: productList.length,
            itemBuilder: (context, index) {
              return Transform.translate(
                offset: Offset(0.0, index.isOdd ? 30 : 0.0),
                child: _buildProductCard(context, productList[index]),
              );
            },
          );
        },
      ),
    );
  }
}
