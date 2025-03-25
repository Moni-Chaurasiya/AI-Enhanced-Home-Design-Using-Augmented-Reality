import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:visionaryhome/screens/details/components/star_rating.dart';
import 'package:visionaryhome/screens/details/details_screen.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:flutter/material.dart';
//import 'package:visionaryhome/data/fetch.dart';

import 'package:visionaryhome/models/product_model.dart';
//import 'package:visionaryhome/screens/home/components/products.dart';
//import 'package:visionaryhome/screens/details/components/product_details.dart';

import '../../../constants/constants.dart';

class ProductPage extends StatefulWidget {
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  List<ProductModel> products = [];
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
        .get();
    List<ProductModel> productList = querySnapshot.docs.map((doc) {
      return ProductModel(
        name: doc.data()['name'],
        quantity: doc.data()['quantity'],
        imageUrl: doc.data()['imageurl'],
        price: doc.data()['price'],
        manufacturer: doc.data()['manfname'],
        description: doc.data()['description'],
        color: doc.data()['color'],
        rating: doc.data()['rating'],
        style: doc.data()['style'],
        madeIn: doc.data()['madein'],
        ARurl: doc.data()['arurl'],
        isFave: doc.data()['isfave'],
        incart: doc.data()['incart'], //  'name':productModel.name,
        // category: doc.data()['category']
      );
    }).toList();
    setState(() {
      products = productList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          Size size = MediaQuery.of(context).size;
          ProductModel productModel = products[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DetailsScreen(
                    product: productModel,
                  ),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(appPadding / 3),
              child: Container(
                color: Colors.white,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        productModel.imageUrl,
                        fit: BoxFit.cover,
                        height: size.height * 0.15,
                        width: size.width * 0.3,
                      ),
                    ),
                    SizedBox(width: appPadding / 3),
                    Expanded(
                      child: Column(
                        children: [
                          const SizedBox(height: 15),
                          Text(
                            ' ${productModel.name}',
                            style: const TextStyle(
                              overflow: TextOverflow.ellipsis,
                              color: black,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 15),
                          Text(
                            '   by ${productModel.manufacturer}',
                            style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              color: Colors.black.withOpacity(0.5),
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          const SizedBox(height: 15),
                          Text(
                            ' ${productModel.price} \₹',
                            style: const TextStyle(
                              overflow: TextOverflow.ellipsis,
                              color: Colors.black54,
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                '${productModel.rating}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              StarRating(rating: productModel.rating),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 150),
                    Column(
                      children: [
                        SizedBox(height: 100),
                        IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                            size: 25,
                          ),
                          onPressed: () async {
                            String uid = FirebaseAuth.instance.currentUser!.uid;
                            CollectionReference<Map<String, dynamic>>
                                productsRef = await FirebaseFirestore.instance
                                    .collection('Users')
                                    .doc(uid)
                                    .collection('favourite');
                            Query<Map<String, dynamic>> query = productsRef
                                .where('name', isEqualTo: productModel.name);
                            QuerySnapshot<Map<String, dynamic>> querySnapshot =
                                await query.get();
                            querySnapshot.docs.forEach((doc) async {
                              await doc.reference.delete();
                            });
                            setState(() {
                              products.remove(productModel);
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
