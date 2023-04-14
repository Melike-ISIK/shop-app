import 'package:alisveris/Data/Favorites.dart';
import 'package:alisveris/Models/Product.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductDetailScreen extends StatefulWidget {
  Product product;
  ProductDetailScreen({Key? key, required this.product}) : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CreateAppBar(),
      body: Column(
        children: [
          Center(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(35))
              ),
              width: double.infinity,
                height: 320,
              child: Image.asset(
                widget.product.imagePath,
                fit: BoxFit.contain,
              )
            ),
          ),
          SizedBox(height: 30,),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              widget.product.name,
                              style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                          Text(
                            "${widget.product.amount}₺",
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30,),
                      Text(widget.product.description),
                    ],
                  ),
                  Spacer(),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.70,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepOrangeAccent,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        )
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          'Sepete Ekle',
                          style: TextStyle(
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      onPressed: (){

                      },
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  AppBar CreateAppBar(){
    return AppBar(
      iconTheme: IconThemeData(color: Colors.black),
      title: Text(
        'Ürün Detay',
        style: TextStyle(
            color: Colors.black
        ),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 12),
          child: InkWell(
            onTap: (){
              setState(() {
                List<Product> favoriteList = Favorites().products;

                bool isProductFavorited = favoriteList.where((Product element) => element.id == widget.product.id).isEmpty;

                if(isProductFavorited != false){
                  Favorites().addFavorites(widget.product);
                }else{
                  Favorites().products.removeWhere((element) => element.id == widget.product.id);
                }
              });
            },
            child: Icon(
              Favorites().products.where((Product element) => element.id == widget.product.id).isEmpty ? Icons.favorite_border : Icons.favorite,
              color: Colors.red,
            ),
          )
        )
      ],
    );
  }
}
