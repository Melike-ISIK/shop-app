import 'package:alisveris/Models/Product.dart';

class Favorites {
  late List<Product> products;

  static final Favorites _singleton = Favorites._internal();

  factory Favorites() {
    return _singleton;
  }

  Favorites._internal(){
    products = [];
  }

  void addFavorites(Product product){
    products.add(product);
  }
}