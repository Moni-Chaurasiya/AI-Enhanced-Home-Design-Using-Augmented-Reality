//
// import 'package:ar_furniture_app/models/product_model.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
//
// class productProvider with ChangeNotifier {
// List <ProductModel> productsList =[];
// late ProductModel productModel;
// fetchData () async{
//   CollectionReference _collectionRef =
//   FirebaseFirestore.instance.collection('products');
//
// List <ProductModel> newlist =[];
//   // Get docs from collection reference
//   QuerySnapshot querySnapshot = await _collectionRef.get();
//   querySnapshot.docs.forEach((element) {
//     productModel = ProductModel (
//       price: element.get("price"),
//       imageUrl: element.get("imageUrl"),
//       color: element.get("color"),
//       style: element.get("style"),
//       name: element.get("name"),
//       description: element.get("description"),
//       madeIn:element.get("madeIn") ,
//
//       manufacturer: element.get("manufacturer"),
//       rating: element.get("rating"),
//       ARurl: element.get("ARurl"),
//
//
//     );
//     productsList=newlist;
//     notifyListeners();
//     print(element.data());
//   });
//
//
//   // Get data from docs and convert map to List
//   // final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
//   // print(allData);
//
// }
// getData(){
// return productsList;
// }
//
// }