import 'package:alisveris/Constants/RouteNames.dart';
import 'package:alisveris/Data/Data.dart';
import 'package:alisveris/Models/Category.dart';
import 'package:alisveris/Models/Product.dart';
import 'package:flutter/material.dart';

class ProductsByCategoryScreen extends StatefulWidget {
  Category category;
  ProductsByCategoryScreen({Key? key, required this.category}) : super(key: key);

  @override
  State<ProductsByCategoryScreen> createState() => _ProductsByCategoryScreenState();
}

class _ProductsByCategoryScreenState extends State<ProductsByCategoryScreen> {
  Data appData = Data();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CreateAppBar(),
      body: ListView.separated(
        separatorBuilder: (BuildContext context, int index) => Divider(color: Colors.deepOrangeAccent,),
        itemCount: appData.products.where((element) => element.category.id == widget.category.id).length,
        itemBuilder: (BuildContext context, int index){
          Product product = appData.products.where((element) => element.category.id == widget.category.id).elementAt(index);

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
        'Kategori: ${widget.category.name}',
        style: TextStyle(
            color: Colors.black
        ),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }
}
