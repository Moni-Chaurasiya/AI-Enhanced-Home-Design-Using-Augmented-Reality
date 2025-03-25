import 'package:visionaryhome/screens/home/home_screen.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'constants/constants.dart';

class cartItem {
  String name;
  String manufacture;
  String image;
  int price;
  int quantity;

  cartItem({
    required this.name,
    required this.manufacture,
    required this.image,
    required this.price,
    required this.quantity,
  });

  Map<String, dynamic> toMap() {
    return {
      'modelname': name,
      'manf': manufacture,
      'price': price,
      'arurl': image,
      'quantity': quantity,
    };
  }
}

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<cartItem> cartItems = [];
  bool isLoading = true;

  final TextEditingController email = TextEditingController();

  final TextEditingController name = TextEditingController();

  final TextEditingController PhoneNumber = TextEditingController();
  final TextEditingController addresse = TextEditingController();

  double total() {
    double total = 0.0;
    for (int i = 0; i < cartItems.length; i++) {
      total += cartItems[i].quantity * cartItems[i].price;
      print(total);
    }
    return total;
  }

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp();
    fetchCartItems();
  }

  Future<void> fetchCartItems() async {
    try {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      final querySnapshot = await FirebaseFirestore.instance
          .collection('Users')
          .doc(uid)
          .collection('cart')
          .get();

      setState(() {
        cartItems = querySnapshot.docs.map((doc) {
          return cartItem(
            quantity: doc.data()['quantity'] ?? 1,
            name: doc.data()['modelname'] ?? '',
            manufacture: doc.data()['manf'] ?? '',
            image: doc.data()['arurl'] ?? '',
            price: doc.data()['price'] ?? 0,
          );
        }).toList();
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching cart items: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // readRecords();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        backgroundColor: Colors.white,
        title: const Text(
          'Shopping Cart',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : cartItems.isEmpty
              ? const Center(child: Text('Your cart is empty'))
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: size.height * 0.7,
                        child: ListView.builder(
                          itemCount: cartItems.length,
                          itemBuilder: (BuildContext context, int index) {
                            Size size = MediaQuery.of(context).size;
                            cartItem item = cartItems[index];

                            return Container(
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 10),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Product Image
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        item.image,
                                        fit: BoxFit.cover,
                                        height: size.height * 0.12,
                                        width: size.width * 0.25,
                                      ),
                                    ),
                                    const SizedBox(width: 15),
                                    // Product Details
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            item.name,
                                            style: const TextStyle(
                                              color: black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            'by ${item.manufacture}',
                                            maxLines: 2,
                                            style: TextStyle(
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w300,
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          // Quantity Controls
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: 15,
                                                height: 15,
                                                child:
                                                    FloatingActionButton.small(
                                                  backgroundColor:
                                                      Colors.orangeAccent,
                                                  child: const Icon(Icons.add,
                                                      size: 10),
                                                  onPressed: () async {
                                                    int quantity = 1;
                                                    setState(() {
                                                      quantity =
                                                          ++item.quantity;
                                                    });

                                                    String uid = FirebaseAuth
                                                        .instance
                                                        .currentUser!
                                                        .uid;
                                                    CollectionReference<
                                                            Map<String,
                                                                dynamic>>
                                                        productsRef =
                                                        FirebaseFirestore
                                                            .instance
                                                            .collection('Users')
                                                            .doc(uid)
                                                            .collection('cart');

                                                    Query<Map<String, dynamic>>
                                                        query = productsRef
                                                            .where('modelname',
                                                                isEqualTo:
                                                                    item.name);
                                                    // print("cart item" + item.name);
                                                    // print(quantity);
                                                    QuerySnapshot<
                                                            Map<String,
                                                                dynamic>>
                                                        querySnapshot =
                                                        await query.get();
                                                    querySnapshot.docs
                                                        .forEach((doc) async {
                                                      await doc.reference
                                                          .update({
                                                        'quantity': quantity
                                                      });
                                                    });
                                                    //fetchCartItems();

                                                    total();
                                                    // updateCart(quantity);
                                                  },
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                child: Text(
                                                  '${item.quantity}',
                                                  style: const TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w900,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 15,
                                                height: 15,
                                                child:
                                                    FloatingActionButton.small(
                                                  backgroundColor:
                                                      Colors.orangeAccent,
                                                  child: const Icon(
                                                      Icons.remove,
                                                      size: 10),
                                                  onPressed: () async {
                                                    if (item.quantity > 1) {
                                                      int quantity = 1;

                                                      setState(() {
                                                        quantity =
                                                            --item.quantity;
                                                      });
                                                      // updateCart(quantity);
                                                      String uid = FirebaseAuth
                                                          .instance
                                                          .currentUser!
                                                          .uid;
                                                      CollectionReference<
                                                              Map<String,
                                                                  dynamic>>
                                                          productsRef =
                                                          FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'Users')
                                                              .doc(uid)
                                                              .collection(
                                                                  'cart');

                                                      Query<
                                                              Map<String,
                                                                  dynamic>>
                                                          query =
                                                          productsRef.where(
                                                              'modelname',
                                                              isEqualTo:
                                                                  item.name);
                                                      // print(
                                                      //     "cart item" + item.name);
                                                      // print(quantity);
                                                      QuerySnapshot<
                                                              Map<String,
                                                                  dynamic>>
                                                          querySnapshot =
                                                          await query.get();
                                                      querySnapshot.docs
                                                          .forEach((doc) async {
                                                        await doc.reference
                                                            .update({
                                                          'quantity': quantity
                                                        });
                                                      });
                                                      //  fetchCartItems();

                                                      total();
                                                    }
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),

                                          // Price and Delete
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                '${item.price} \₹',
                                                style: const TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w900,
                                                ),
                                              ),
                                              IconButton(
                                                icon: const Icon(
                                                  Icons.delete,
                                                  size: 15,
                                                ),
                                                onPressed: () async {
                                                  // Your existing delete code

                                                  String uid = FirebaseAuth
                                                      .instance
                                                      .currentUser!
                                                      .uid;
                                                  CollectionReference<
                                                          Map<String, dynamic>>
                                                      productsRef =
                                                      FirebaseFirestore.instance
                                                          .collection('Users')
                                                          .doc(uid)
                                                          .collection('cart');

                                                  Query<Map<String, dynamic>>
                                                      query = productsRef.where(
                                                          'modelname',
                                                          isEqualTo: item.name);
                                                  //print("cart item" + item.name);
                                                  QuerySnapshot<
                                                          Map<String, dynamic>>
                                                      querySnapshot =
                                                      await query.get();
                                                  querySnapshot.docs
                                                      .forEach((doc) async {
                                                    await doc.reference
                                                        .delete();
                                                  });
                                                  // setState(() {
                                                  fetchCartItems();
                                                  // });

                                                  //print("delete cart item");
                                                  total();
                                                },
                                              ),
                                            ],
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
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 15, left: 6, right: 6, bottom: 0),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(10),
                                topLeft: Radius.circular(10)),
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height: size.height * 0.035,
                              ),
                              Text(
                                'Total Amount :  ${total()}\₹',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(height: size.height * 0.012),
                              MaterialButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        _buildPopupDialog(context),
                                  );
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 3),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Color.fromARGB(255, 1, 34, 84),
                                      // gradient: const LinearGradient(
                                      //   begin: Alignment.centerLeft,
                                      //   colors: <Color>[
                                      //     Color(0xffff5983),
                                      //     Colors.orangeAccent,
                                      //   ],
                                      // )
                                    ),
                                    width: double.infinity,
                                    height: 50.0,
                                    child: const Center(
                                      child: Text(
                                        "Confirm Order",
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }

  Widget _buildPopupDialog(BuildContext context) {
    return AlertDialog(
      title: const Text('Order Confirmation & Payment Details'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text("Payment by cash on delviery "),
          TextField(
            controller: name,
            decoration: const InputDecoration(
              hintText: 'Name',
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          TextField(
            controller: email,
            decoration: const InputDecoration(
              hintText: 'Email',
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          TextField(
            controller: addresse,
            decoration: const InputDecoration(
              hintText: 'Address',
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          TextField(
            controller: PhoneNumber,
            decoration: const InputDecoration(
              hintText: 'Phone',
            ),
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Close', style: TextStyle(color: Colors.black)),
        ),
        TextButton(
          onPressed: () async {
            String uid = FirebaseAuth.instance.currentUser!.uid;
            // Navigator.of(context).pop();
            final CollectionReference usersCollection = FirebaseFirestore
                .instance
                .collection('Users')
                .doc(uid)
                .collection('orders');
            //  final CollectionReference usersCollection = await FirebaseFirestore.instance.collection('cart');
            // print(usersCollection.parent);
            Random random = Random();
            int randomNumber = random.nextInt(100000) + 1;
            var date = DateTime.now();
            //print("date"+date.toString());
            //print("random"+randomNumber.toString());
            // List yourItemList = [];
            // for (int i = 0; i < cartItems.length; i++)
            //   yourItemList.add({
            //     "name": itemName.toList()[i],
            //     "price": rate.toList()[i],
            //     "quantity": quantity.toList()[i]
            //   });

            Map<String, dynamic> orderDetails = {
              'userName': name.text,
              'phone': PhoneNumber.text,
              'email': email.text,
              'address': addresse.text,
              'date': date.toString(),
              'orderPrice': total().toString(),
              'orderNumber': randomNumber,
              'orderDetails': cartItems.map<Map>((e) => e.toMap()).toList(),
            };
            usersCollection.add(orderDetails);
            final CollectionReference ordersCollection = FirebaseFirestore
                .instance
                .collection('Users')
                .doc(uid)
                .collection('cart');
            final QuerySnapshot querySnapshot = await ordersCollection.get();

            querySnapshot.docs.forEach((document) {
              document.reference.delete();
            });
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const HomeScreen()));
          },
          child: const Text('Confirm', style: TextStyle(color: Colors.black)),
        ),
      ],
    );
  }
}
