import 'package:alisveris/Constants/RouteNames.dart';
import 'package:alisveris/Data/Data.dart';
import 'package:alisveris/Models/Gender.dart';
import 'package:alisveris/Models/Product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductsByGender extends StatefulWidget {
  Gender gender;

  ProductsByGender({Key? key, required this.gender}) : super(key: key);

  @override
  State<ProductsByGender> createState() => _ProductsByGenderState();
}

class _ProductsByGenderState extends State<ProductsByGender> {
  Data data = Data();
  List<Product> results = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    data.products.forEach((Product element) {
      if(element.gender.index == widget.gender.index){
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
        )
    );
  }

  AppBar CreateAppBar(){
    return AppBar(
      iconTheme: IconThemeData(color: Colors.black),
      title: Text(
        'Cinsiyet: ${widget.gender.name == "Male" ? "Erkek" : "Kadın"}',
        style: TextStyle(
            color: Colors.black
        ),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }
}


