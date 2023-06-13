import 'package:alisveris/Constants/RouteNames.dart';
import 'package:alisveris/Data/Data.dart';
import 'package:alisveris/Data/Favorites.dart';
import 'package:alisveris/Helpers/SQLiteHelper.dart';
import 'package:alisveris/Models/Favorite.dart';
import 'package:alisveris/Models/Product.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  SQLiteHelper sqliteHelper = SQLiteHelper.instance;
  late Future<Database> sqlitedb;

  Data data = Data();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sqlitedb = SQLiteHelper.instance.database;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CreateAppBar(),
        body: FutureBuilder(
          future: sqliteHelper.getFavorites(),
          builder: (context, snapshot){
            if(!snapshot.hasData) return CircularProgressIndicator();

            List<Favorite>? favorites = snapshot.data;

            return ListView.separated(
              separatorBuilder: (context, index) => Divider(),
              itemCount: favorites!.length,
              itemBuilder: (context, index){
                Favorite favorite = favorites[index];

                Product product = data.products.firstWhere((element) => element.id == favorite.productId);

                return ListTile(
                  leading: Image.asset(product.imagePath, width: 35,),
                  title: Text(product.name),
                  subtitle: Text('${product.amount}₺'),
                  onTap: (){
                    Navigator.pushNamed(context, productDetailRoute, arguments: product).then((values){setState((){});});
                  },
                );
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
