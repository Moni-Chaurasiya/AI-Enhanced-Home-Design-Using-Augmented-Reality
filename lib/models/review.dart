class Review{
  String name,comment;
  Review(this.name,this.comment);
  static Review fromJason(Map<String,dynamic> jason){
    return Review(jason["name"], jason["comment"]);
  }
  Map<String,dynamic> toJason(){
    return {
      'name': name,
      'comment': comment
    };
  }

}