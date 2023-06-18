import 'dart:async';
import 'package:alisveris/Helpers/FirebaseHelper.dart';
import 'package:alisveris/Helpers/SQLiteHelper.dart';
import 'package:alisveris/Models/Favorite.dart';
import 'package:alisveris/Models/Product.dart';
import 'package:alisveris/Models/ShoppingItem.dart';
import 'package:alisveris/Screens/ProductCommentsScreen.dart';
import 'package:flutter/material.dart';

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

  FirebaseHelper _firebaseHelper = FirebaseHelper();
  SQLiteHelper helper = SQLiteHelper.instance;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: CreateAppBar(),
          body: TabBarView(
            children: [
              ProductContent(),
              ProductCommentsScreen(product: widget.product,)
            ],
          )
      ),
    );
  }

  GestureDetector ProductContent(){
    return GestureDetector(
      onVerticalDragEnd: (DragEndDetails? details){
        Navigator.of(context).pop();
      },
      child: Column(
        children: [
          Center(
            child: Stack(
                children: [
                  Hero(
                    tag: 'product-${widget.product.name}',
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
                        ),
                    ),
                  ),
                  if(widget.product.isDiscounted) IndirimWidget()
                ]
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
                            child: Wrap(
                                children:[
                                  Text(
                                    widget.product.name,
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ]
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
                    child: GestureDetector(
                      onHorizontalDragEnd: (DragEndDetails? details){

                      },
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
                          late StreamSubscription cartSubscription;

                          cartSubscription =
                              _firebaseHelper.StreamCart().listen((cartListFromFirestore){
                                List<ShoppingItem> items = cartListFromFirestore.where((element) => element.productId == widget.product.id).toList();
                                if(items.isEmpty) {
                                  _firebaseHelper.AddCart(ShoppingItem(
                                    docId: '',
                                    amount: widget.product.amount,
                                    name:  widget.product.name,
                                    imagePath: widget.product.imagePath,
                                    quantity: 1,
                                    productId: widget.product.id,));
                                }else{
                                  _firebaseHelper.UpdateCart(ShoppingItem(
                                    amount: items.first.amount,
                                    docId: items.first.docId,
                                    name: items.first.name,
                                    productId: items.first.productId,
                                    imagePath: items.first.imagePath,
                                    quantity: items.first.quantity + 1,
                                  ));}
                                cartSubscription.cancel();
                              },
                              );
                        },
                      ),
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
      bottom: TabBar(
        indicatorColor: Colors.deepOrangeAccent,
        tabs: [
          Tab(icon: Icon(Icons.explore, color: Colors.deepOrangeAccent,)),
          Tab(icon: Icon(Icons.comment, color: Colors.deepOrangeAccent,)),
        ],
      ),
      actions: [
        Padding(
            padding: EdgeInsets.only(right: 12),
            child: FutureBuilder(
                future: helper.getFavorites(),
                builder: (context, snapshot) {
                  if(!snapshot.hasData) return CircularProgressIndicator();

                  List<Favorite>? favorites = snapshot.data;

                  bool isFavorited = favorites!.where((element) => element.productId == widget.product.id).toList().isEmpty;

                  return InkWell(
                      onTap: () async{
                        setState(() {
                          if(isFavorited){
                            helper.insertItem(Favorite(
                                productId: widget.product.id
                            ), SQLiteHelper.favoriteTable);
                          }else{
                            helper.removeItem(
                                SQLiteHelper.favoriteTable,
                                'productId',
                                widget.product.id);
                          }
                        });
                      },
                      child: FutureBuilder(
                        future: helper.getFavorites(),
                        builder: (context, AsyncSnapshot<List<Favorite>> snapshot){
                          if(!snapshot.hasData) return CircularProgressIndicator();

                          List<Favorite>? favorites = snapshot.data;

                          bool isFavorited = favorites!.where((element) => element.productId == widget.product.id).toList().isEmpty;

                          return Icon(
                            isFavorited ? Icons.favorite_border : Icons.favorite,
                            color: Colors.deepOrangeAccent,
                          );
                        },
                      )
                  );
                }
            )
        )
      ],
    );
  }
}

class IndirimWidget extends StatefulWidget {
  const IndirimWidget({Key? key}) : super(key: key);

  @override
  State<IndirimWidget> createState() => _IndirimWidgetState();
}

class _IndirimWidgetState extends State<IndirimWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _backgroundColorTween;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(seconds: 1));
    _backgroundColorTween = ColorTween(begin: Colors.red, end: Colors.yellow).animate(_controller);
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _backgroundColorTween,
      builder:(context, child){
        return Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
              color: _backgroundColorTween.value,
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(12))
          ),
          child: Transform.rotate(angle:50.15,child: Text('İNDİRİM!', style: TextStyle(fontWeight: FontWeight.bold),)),
        );
      },
    );
  }
}
