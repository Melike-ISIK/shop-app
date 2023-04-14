import 'package:alisveris/Constants/RouteNames.dart';
import 'package:alisveris/Data/Data.dart';
import 'package:alisveris/Data/Favorites.dart';
import 'package:alisveris/Models/Category.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoriesScreen extends StatefulWidget {
  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  Data appData = Data();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CreateAppBar(),
        body: ListView.separated(
          separatorBuilder: (BuildContext context, int index) => Divider(color: Colors.deepOrangeAccent),
          itemCount: appData.categories.length,
          itemBuilder: (BuildContext context, int index){
            Category category = appData.categories[index];
            return ListTile(
              leading: Image.asset(category.imagePath, width: 35,),
              title: Text(category.name),
              onTap: (){
                Navigator.pushNamed(context, productsByCategoryRoute, arguments: category);
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
        'Kategoriler',
        style: TextStyle(
            color: Colors.black
        ),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }
}
