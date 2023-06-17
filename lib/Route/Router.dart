import 'package:alisveris/Components/BottomBarRouter.dart';
import 'package:alisveris/Constants/RouteNames.dart';
import 'package:alisveris/Models/Gender.dart';
import 'package:alisveris/Models/Product.dart';
import 'package:alisveris/Models/Category.dart';
import 'package:alisveris/Screens/AddAddressScreen.dart';
import 'package:alisveris/Screens/AllProductsScreen.dart';
import 'package:alisveris/Screens/CategoriesScreen.dart';
import 'package:alisveris/Screens/ChooseAddressScreen.dart';
import 'package:alisveris/Screens/FavoritesScreen.dart';
import 'package:alisveris/Screens/HomeScreen.dart';
import 'package:alisveris/Screens/LoginScreen.dart';
import 'package:alisveris/Screens/NotFoundScreen.dart';
import 'package:alisveris/Screens/OrderCompletedScreen.dart';
import 'package:alisveris/Screens/ProductDetailScreen.dart';
import 'package:alisveris/Screens/ProductsByCategoryScreen.dart';
import 'package:alisveris/Screens/ProductsByGender.dart';
import 'package:alisveris/Screens/RegisterScreen.dart';
import 'package:alisveris/Screens/SearchScreen.dart';
import 'package:alisveris/Screens/UserAddressScreen.dart';
import 'package:alisveris/Screens/UserProfileScreen.dart';
import 'package:flutter/material.dart';

class Router{
  static Route<dynamic> generateRoute(RouteSettings settings){
    switch(settings.name){
      case loginRoute: return MaterialPageRoute(builder: (context) => LoginScreen());
      case homeRoute: return MaterialPageRoute(builder: (context) => HomeScreen());
      case allProductsRoute: return MaterialPageRoute(builder: (context) => AllProductsScreen());
      case categoriesRoute: return MaterialPageRoute(builder: (context) => CategoriesScreen());
      case bottomBarRoute: return MaterialPageRoute(builder: (context) => BottomBarRouter());
      case favoritesRoute: return MaterialPageRoute(builder: (context) => FavoritesScreen());
      case searchRoute: return MaterialPageRoute(builder: (context) => SearchScreen(searchText: settings.arguments as String,));
      case productsByGenderRoute: return MaterialPageRoute(builder: (context) => ProductsByGender(gender: settings.arguments as Gender,));
      case productsByCategoryRoute: return MaterialPageRoute(builder: (context) => ProductsByCategoryScreen(category: settings.arguments as Category,));
      case productDetailRoute: return MaterialPageRoute(builder: (context) => ProductDetailScreen(product: settings.arguments as Product,));
      case registerRoute: return MaterialPageRoute(builder: (context) => RegisterScreen());
      case userProfileRoute: return MaterialPageRoute(builder: (context) => UserProfileScreen());
      case userAddressRoute: return MaterialPageRoute(builder: (context) => UserAddressScreen());
      case addAddressRoute: return MaterialPageRoute(builder: (context) => AddAddressScreen());
      case chooseAddressRoute: return MaterialPageRoute(builder: (context) => ChooseAddressScreen());
      case orderCompletedRoute: return MaterialPageRoute(builder: (context) => OrderCompletedScreen());
      default:
        return MaterialPageRoute(builder: (context) => NotFoundScreen());
    }
  }
}