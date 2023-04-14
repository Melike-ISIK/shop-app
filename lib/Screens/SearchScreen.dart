import 'package:alisveris/Constants/RouteNames.dart';
import 'package:alisveris/Data/Data.dart';
import 'package:alisveris/Models/Product.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  String searchText;

  SearchScreen({Key? key, required this.searchText}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  Data data = Data();
  List<Product> results = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    data.products.forEach((Product element) {
      if(element.name.toLowerCase().contains(widget.searchText.toLowerCase())){
        results.add(element);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CreateAppBar(),
      body: ListView.separated(
        separatorBuilder: (BuildContext context, int index) => Divider(color: Colors.deepOrangeAccent),
        itemCount: results.length,
        itemBuilder: (BuildContext context, int index){
          Product product = results[index];

          return ListTile(
            leading: Image.asset(product.imagePath, width: 35,),
            title: Text(product.name),
            subtitle: Text('${product.amount}₺'),
            onTap: (){
              Navigator.pushNamed(context, productDetailRoute, arguments: product);
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
        'Ara: ${widget.searchText}',
        style: TextStyle(
            color: Colors.black
        ),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }
}