import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:visionaryhome/models/product_model.dart';
import 'package:visionaryhome/screens/details/components/product_details.dart';

import '../../details/components/star_rating.dart';
import '../../details/details_screen.dart';
import '../../../constants/constants.dart';

List<Record> records = [];

class Record {
  String param1;
  String param2;
  String param5;
  int price;
  int quantity;

  Record({
    required this.param1,
    required this.param2,
    required this.param5,
    required this.price,
    required this.quantity,
  });

  factory Record.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    Map<String, dynamic> data = snapshot.data()!;
    return Record(
      param1: data['arurl'],
      param2: data['manf'],
      param5: data['modelname'],
      price: data['price'],
      quantity: data['quantity'],
    );
  }
}

Future<void> readRecords() async {
  QuerySnapshot<Map<String, dynamic>> querySnapshot =
      await FirebaseFirestore.instance.collection('favourite').get();
  print("before");

  querySnapshot.docs.forEach((doc) {
    print(doc.id);

    print("object");
    records.add(Record.fromFirestore(doc));
    print("oafeter  bject");
  });
}

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: const Text(
          "Favourite",
          style: TextStyle(
            fontSize: 30,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.all(appPadding / 2),
          itemCount: add_notes_state.Fav_lst.length,
          itemBuilder: (context, index) {
            ProductModel productModel = add_notes_state.Fav_lst[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DetailsScreen(product: productModel),
                  ),
                );
              },
              child: Card(
                margin: const EdgeInsets.only(bottom: appPadding),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(appPadding / 2),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Product Image
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          productModel.imageUrl,
                          height: 120,
                          width: 120,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 16),
                      // Product Details
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              productModel.name,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: black,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'by ${productModel.manufacturer}',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black.withOpacity(0.5),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '${productModel.price} EG',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black54,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Text(
                                  '${productModel.rating}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                StarRating(rating: productModel.rating),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // Favorite Icon
                      IconButton(
                        icon: const Icon(
                          Icons.favorite,
                          color: Colors.red,
                          size: 24,
                        ),
                        onPressed: () {
                          // Handle removing from favorites
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
