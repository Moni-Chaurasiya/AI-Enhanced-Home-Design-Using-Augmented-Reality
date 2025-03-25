
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../cart.dart';

class CartProvider with ChangeNotifier{
  List<cartItem> cartItems = [];
  int q=1;
  Future<void> fetchCartItems() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;

    QuerySnapshot<Map<String, dynamic>> querySnapshot =
    await  FirebaseFirestore.instance.collection('Users').doc(uid).collection('cart').get();
    List<cartItem> items = querySnapshot.docs.map((doc) {
      return cartItem(quantity:doc.data()['quantity'] , name: doc.data()['modelname'], manufacture: doc.data()['manf'], image: doc.data()['arurl'], price:doc.data()['price'] ,
      );
    }).toList();
    // setState(() {
    cartItems = items;
    notifyListeners();
    // });
  }
  void setQuantity( cartItem item  ){
    q=item.quantity;
  }
void add (){
  q++;
  notifyListeners();
}
void minus (){


      q--;

  notifyListeners();
}
}