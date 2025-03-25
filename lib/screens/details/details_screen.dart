import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../constants/constants.dart';
import '../../models/product_model.dart';
import 'components/productDetail.dart';
import 'components/product_image.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({Key? key, required this.product}) : super(key: key);
  final ProductModel product;

  @override
  _ProductPageState createState() => _ProductPageState(product);
}

class _ProductPageState extends State<DetailsScreen> {
  List<ProductModel> products = [];
  bool isLoading = true;

  _ProductPageState(this.product);
  final ProductModel product;

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;

    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection('Users')
        .doc(uid)
        .collection('favourite')
        .where('name', isEqualTo: product.name)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      setState(() {
        product.isFave = true;
        isLoading = false;
      });
    } else {
      setState(() {
        product.isFave = false;
        isLoading = false;
      });
      print('No documents found in the products collection.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ProductImage(imageUrl: product.imageUrl),
                add_notes(productModel: product),
              ],
            ),
            Positioned(
              top: 10,
              right: 10,
              child: IconButton(
                icon: Icon(Icons.close, color: Colors.black, size: 24),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the popup
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Open the popup when tapped
void showProductPopup(BuildContext context, ProductModel product) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return DetailsScreen(product: product);
    },
  );
}
