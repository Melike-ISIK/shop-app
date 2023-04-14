import 'package:alisveris/Constants/RouteNames.dart';
import 'package:alisveris/Data/Data.dart';
import 'package:alisveris/Models/Product.dart';
import 'package:flutter/material.dart';

class AllProductsScreen extends StatelessWidget {
  Data appData = Data();

  @override
  Widget build(BuildContext context) {
    List<Product> products = appData.products;
    products.sort((b,a) => a.createdAt.toString().compareTo(b.createdAt.toString()));

    return Scaffold(
      appBar: CreateAppBar(),
      body: ListView.separated(
        separatorBuilder: (BuildContext context, int index) => Divider(color: Colors.deepOrangeAccent),
        itemCount: products.length,
        itemBuilder: (BuildContext context, int index){
          Product product = products[index];
          return ListTile(
            leading: Image.asset(product.imagePath),
            title: Text(product.name),
            subtitle: Text('${product.amount}₺'),
            onTap: (){
              Navigator.pushNamed(context, productDetailRoute, arguments: product);
            },
          );
        },
      )
    );
  }

  AppBar CreateAppBar(){
    return AppBar(
      iconTheme: IconThemeData(color: Colors.black),
      title: Text(
          'Ürünler',
        style: TextStyle(
          color: Colors.black
        ),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }
}
