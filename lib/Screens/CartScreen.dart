import 'package:alisveris/Constants/RouteNames.dart';
import 'package:alisveris/Helpers/FirebaseHelper.dart';
import 'package:alisveris/Helpers/ToastHelper.dart';
import 'package:alisveris/Models/ShoppingItem.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  FirebaseHelper _firebaseHelper = FirebaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CreateAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: _firebaseHelper.StreamCart(),
                builder: (BuildContext context, AsyncSnapshot<List<ShoppingItem>> snapshot){
                  if(!snapshot.hasData) return CircularProgressIndicator();

                  if(snapshot.data!.isEmpty) return Center(child: const Text('Sepetiniz boş.'));

                  List<ShoppingItem>? shoppingItems = snapshot.data;

                  return ListView.builder(
                    itemCount: shoppingItems?.length,
                    itemBuilder: (context, index){
                      ShoppingItem item = shoppingItems![index];

                      return GestureDetector(
                        onHorizontalDragEnd: (DragEndDetails? details){
                          _firebaseHelper.DeleteCart(item);
                        },
                        child: ListTile(
                          leading: Image.asset(item.imagePath),
                          title: Text(item.name),
                          subtitle: Text("${item.amount}₺"),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.remove),
                                onPressed: (){
                                  if(item.quantity - 1 == 0){
                                    _firebaseHelper.DeleteCart(item);
                                  }
                                  else
                                  {
                                    _firebaseHelper.UpdateCart(ShoppingItem(
                                        amount: item.amount,
                                        productId: item.productId,
                                        quantity: item.quantity - 1,
                                        imagePath: item.imagePath,
                                        name: item.name,
                                        docId: item.docId
                                    ));
                                  }
                                },
                              ),
                              SizedBox(
                                  width: 35,
                                  child: Text(
                                      item.quantity.toString(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15
                                      )
                                  )
                              ),
                              IconButton(
                                icon: Icon(Icons.add),
                                onPressed: (){
                                  _firebaseHelper.UpdateCart(ShoppingItem(
                                      amount: item.amount,
                                      productId: item.productId,
                                      quantity: item.quantity + 1,
                                      imagePath: item.imagePath,
                                      name: item.name,
                                      docId: item.docId
                                  ));
                                },
                              ),

                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            Container(
              child: StreamBuilder(
                stream: _firebaseHelper.CalculateTotalPrice(),
                builder: (BuildContext context, AsyncSnapshot<double> snapshot){
                  if(!snapshot.hasData) CircularProgressIndicator();

                  if(snapshot.data == null) return CircularProgressIndicator();

                  return Column(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text('Toplam Fiyat', style: TextStyle(fontWeight: FontWeight.bold),),
                                Spacer(),
                                Text('${snapshot.data}₺'),
                              ],
                            ),
                            Container(
                                width: double.infinity,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.deepOrangeAccent,
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(25),
                                      )
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      'Sipariş Ver',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                                  onPressed: (){
                                    if(snapshot.data == 0){
                                      ToastHelper().makeToastMessage('Sepetinizde ürün bulunmamaktadır.');
                                    }else{
                                      Navigator.pushNamed(context, chooseAddressRoute);
                                    }
                                  },
                                )
                            )
                          ],
                        )
                      ]
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar CreateAppBar(){
    return AppBar(
      iconTheme: IconThemeData(
          color: Colors.black
      ),
      title: Text(
        'Sepet',
        style: TextStyle(
            color: Colors.black
        ),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
    );
  }
}