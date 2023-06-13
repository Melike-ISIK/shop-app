class Favorite{
  late int productId;

  Favorite({required this.productId});

  Map<String, dynamic> toMap(){
    var map = Map<String, dynamic>();
    map["productId"] = productId;
    return map;
  }

  Favorite.fromMap(Map<String, dynamic> map){
    productId = map['productId'];
  }
}