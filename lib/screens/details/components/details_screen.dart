import 'package:visionaryhome/screens/details/components/product_details.dart';
import 'package:visionaryhome/screens/details/components/product_image.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../constants/constants.dart';
import '../../../models/product_model.dart';
import '../../home/components/custom_appbar.dart';

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
    //String uid = FirebaseAuth.instance.currentUser!.uid;
    String uid = "7gkm6w6XfhnaC2tWUD4Q";
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
    return Scaffold(
      backgroundColor: white,
      body: SingleChildScrollView(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Column(children: [
              ProductImage(
                imageUrl: product.imageUrl,
              ),
              add_notes(
                productModel: product,
              ),
            ]),
            CustomAppBar(),
          ],
        ),
      ),
    );
  }
}
