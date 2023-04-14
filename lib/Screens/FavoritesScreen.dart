import 'package:alisveris/Constants/RouteNames.dart';
import 'package:alisveris/Data/Favorites.dart';
import 'package:alisveris/Models/Product.dart';
import 'package:flutter/material.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CreateAppBar(),
      body: ListView.separated(
        separatorBuilder: (BuildContext context, int index) => Divider(color: Colors.deepOrangeAccent),
        itemCount: Favorites().products.length,
        itemBuilder: (BuildContext context, int index){
          if(Favorites().products.isEmpty) return Text('Favorilerde ürün bulunmuyor.');

          Product product = Favorites().products[index];

          return ListTile(
            leading: Image.asset(product.imagePath, width: 35,),
            title: Text(product.name),
            subtitle: Text('${product.amount}₺'),
            onTap: (){
              Navigator.pushNamed(context, productDetailRoute, arguments: product).then((values){setState((){});});
            },
          );
        },
      ),
    );
  }

  AppBar CreateAppBar(){
    return AppBar(
      iconTheme: IconThemeData(color: Colors.black),
      title: Text(
        'Favoriler',
        style: TextStyle(
            color: Colors.black
        ),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }
}
