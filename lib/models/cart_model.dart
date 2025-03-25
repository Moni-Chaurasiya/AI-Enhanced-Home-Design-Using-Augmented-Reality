class CartModel{

  String imageUrl;
  String name;
  int price;
  int quantity ;

  String userEmail;

CartModel(
     this.name,
     this.imageUrl,
     this.price,
     this.quantity,
   
     this.userEmail,

  );
  static CartModel fromJason(Map<String,dynamic> jason){
    return CartModel(jason["imageUrl"],jason["name"], jason["price"],jason["quantity"],jason["userEmail"]);
  }
  Map<String,dynamic> toJason() {
    return {
      'imageUrl': imageUrl,
      'name': name,
      'price': price,
      'quantity': quantity,
      'userEmail': userEmail
    };
  }
}