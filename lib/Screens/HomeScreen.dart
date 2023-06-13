import 'dart:io';

import 'package:alisveris/Components/CategoryCard.dart';
import 'package:alisveris/Components/ProductCard.dart';
import 'package:alisveris/Constants/RouteNames.dart';
import 'package:alisveris/Data/Data.dart';
import 'package:alisveris/Models/Category.dart';
import 'package:alisveris/Models/Gender.dart';
import 'package:alisveris/Models/Product.dart';
import 'package:alisveris/Models/UserLocation.dart';
import 'package:alisveris/Services/GeoLocationService.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<UserLocation> userLocation;
  late SharedPreferences prefs;

  Future getPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  readLastLogins() async{
    try {
      final directory = await getApplicationDocumentsDirectory();
      File file = File('${directory.path}/signedUsers.txt');
      String fileContents = await file.readAsString();
      print(fileContents);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPrefs();
    readLastLogins();
    userLocation = GetUserLocation();
  }

  @override
  Widget build(BuildContext context) {
    Data appData = Data();
    TextEditingController search = TextEditingController(text: '');
    List<Product> products = appData.products;
    products.sort((a,b) => b.createdAt.toString().compareTo(a.createdAt.toString()));

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: CreateAppBar(),
      drawer: CreateDrawer(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                child: Text(
                  'Keşfet',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 22,
                  ),
                ),
              ),
              SizedBox(height: 5,),
              Container(
                width: double.infinity,
                child: Text(
                  'Senin için en iyi kıyafetler',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey
                  ),
                ),
              ),
              SizedBox(height: 25,),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: search,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black12,
                              )
                          ),
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.search)
                      ),
                    ),
                  ),
                  SizedBox(width: 15,),
                  SizedBox(
                    height: 55,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepOrangeAccent,
                        elevation: 0
                      ),
                      child: Text(
                        'Ara'
                      ),
                      onPressed: (){
                        Navigator.pushNamed(context, searchRoute, arguments: search.text);
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25,),
              SizedBox(
                width: double.infinity,
                height: 90,
                child: ListView.separated(
                  separatorBuilder: (context, index) => SizedBox(width: 12,),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: appData.categories.length,
                  itemBuilder: (BuildContext context, int index){
                    Category category = appData.categories[index];

                    return CategoryCard(
                      imagePath: category.imagePath,
                      name: category.name,
                      onTap: (){
                        Navigator.pushNamed(context, productsByCategoryRoute, arguments: category);
                      },
                    );
                  },
                ),
              ),
              SizedBox(height: 25,),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      child: Text(
                        'Son Eklenenler',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.pushNamed(context, allProductsRoute);
                    },
                    child: Chip(
                      label: Text('Tümünü Gör'),
                    ),
                  ),
                ],
              ),
              GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    mainAxisExtent: 220,
                    childAspectRatio: 3/3,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20),
                itemCount: 4,
                itemBuilder: (BuildContext context, int index){
                  Product product = products[index];

                  return ProductCard(
                    name: product.name,
                    amount: product.amount,
                    imagePath: product.imagePath,
                    onTap: (){
                      Navigator.pushNamed(context, productDetailRoute, arguments: product);
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Drawer CreateDrawer(BuildContext context){
    return Drawer(
      child: Column(
        children: [
          ListView(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.deepOrangeAccent,
                ),
                child: FutureBuilder(
                  future: SharedPreferences.getInstance(),
                  builder: (BuildContext context, AsyncSnapshot<SharedPreferences> snapshot){
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return CircularProgressIndicator();
                    }

                    return Column(
                      children: [
                        Container(width:double.infinity, child: Text('Kullanıcı: ${snapshot.data?.getString('name')}')),
                        FutureBuilder(
                          future: userLocation,
                          builder: (context, AsyncSnapshot<UserLocation> snapshot){
                            if(!snapshot.hasData) return CircularProgressIndicator();

                            return Container(
                                width:double.infinity,
                                child: Text('Konum: ${snapshot.data!.city}, ${snapshot.data!.countryCode}')
                            );
                          },
                        )
                      ],
                    );
                  },
                )
              ),
              ListTile(
                title: const Text('Ana Sayfa'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
              ListTile(
                title: const Text('Kategoriler'),
                onTap: () {
                  Navigator.pushNamed(context, categoriesRoute);
                },
              ),
              ListTile(
                title: const Text('Kadın'),
                onTap: () {
                  Navigator.pushNamed(context, productsByGenderRoute, arguments: Gender.Female);
                },
              ),
              ListTile(
                title: const Text('Erkek'),
                onTap: () {
                  Navigator.pushNamed(context, productsByGenderRoute, arguments: Gender.Male);
                },
              )
            ],
          ),
          Spacer(),
          ListTile(
            title: const Text('Çıkış'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, loginRoute);
            },
          ),
        ],
      )
    );
  }

  AppBar CreateAppBar(){
    return AppBar(
      iconTheme: IconThemeData(color: Colors.black),
      title: Text(
          'Ana Sayfa',
        style: TextStyle(
          color: Colors.black
        ),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }
}
